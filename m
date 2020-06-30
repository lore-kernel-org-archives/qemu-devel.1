Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E255EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F362074F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F362074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIn8-0001YD-1U
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqImW-00016u-96
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:06:48 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:57404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jqImT-00017e-DO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:06:48 -0400
Received: from player763.ha.ovh.net (unknown [10.110.208.89])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id AC49D1717EF
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 18:06:42 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id C445E13E6A408;
 Tue, 30 Jun 2020 16:06:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0012c17efb8-b732-40c5-b68e-619cb406f233,321FFE8278D843C460097280AF09A0BF63DC926D)
 smtp.auth=groug@kaod.org
Date: Tue, 30 Jun 2020 18:06:30 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/2] net: tap: check if the file descriptor is valid
 before using it
Message-ID: <20200630180630.2ca955b8@bahia.lan>
In-Reply-To: <20200630145737.232095-2-lvivier@redhat.com>
References: <20200630145737.232095-1-lvivier@redhat.com>
 <20200630145737.232095-2-lvivier@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7138768359337859366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtddtgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefieekheeljeejtefggfehgeehffetjeegtedtueekleefiefhjeejtdduteegtdenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeifedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.41.146; envelope-from=groug@kaod.org;
 helo=1.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 12:06:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 16:57:36 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> qemu_set_nonblock() checks that the file descriptor can be used and, if
> not, crashes QEMU. An assert() is used for that. The use of assert() is
> used to detect programming error and the coredump will allow to debug
> the problem.
> 
> But in the case of the tap device, this assert() can be triggered by
> a misconfiguration by the user. At startup, it's not a real problem, but it
> can also happen during the hot-plug of a new device, and here it's a
> problem because we can crash a perfectly healthy system.
> 
> For instance:
>  # ip link add link virbr0 name macvtap0 type macvtap mode bridge
>  # ip link set macvtap0 up
>  # TAP=/dev/tap$(ip -o link show macvtap0 | cut -d: -f1)
>  # qemu-system-x86_64 -machine q35 -device pcie-root-port,id=pcie-root-port-0 -monitor stdio 9<> $TAP
>  (qemu) netdev_add type=tap,id=hostnet0,vhost=on,fd=9
>  (qemu) device_add driver=virtio-net-pci,netdev=hostnet0,id=net0,bus=pcie-root-port-0
>  (qemu) device_del net0
>  (qemu) netdev_del hostnet0
>  (qemu) netdev_add type=tap,id=hostnet1,vhost=on,fd=9
>  qemu-system-x86_64: .../util/oslib-posix.c:247: qemu_set_nonblock: Assertion `f != -1' failed.
>  Aborted (core dumped)
> 
> To avoid that, check the file descriptor is valid before passing it to
> qemu_set_non_block() for "fd=" and "fds=" parameters.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  include/qemu/sockets.h |  1 +
>  net/tap.c              | 13 +++++++++++++
>  util/oslib-posix.c     |  5 +++++
>  util/oslib-win32.c     |  6 ++++++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
> index 57cd049d6edd..5b0c2d77ddad 100644
> --- a/include/qemu/sockets.h
> +++ b/include/qemu/sockets.h
> @@ -17,6 +17,7 @@ int qemu_socket(int domain, int type, int protocol);
>  int qemu_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
>  int socket_set_cork(int fd, int v);
>  int socket_set_nodelay(int fd);
> +bool qemu_fd_is_valid(int fd);
>  void qemu_set_block(int fd);
>  void qemu_set_nonblock(int fd);
>  int socket_set_fast_reuse(int fd);
> diff --git a/net/tap.c b/net/tap.c
> index 6207f61f84ab..f65966aaccd8 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -795,6 +795,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
>              return -1;
>          }
>  
> +        /* Check if fd is valid */
> +        if (!qemu_fd_is_valid(fd)) {
> +            error_setg(errp, "Invalid file descriptor %d", fd);
> +            return -1;
> +        }
> +
>          qemu_set_nonblock(fd);
>  
>          vnet_hdr = tap_probe_vnet_hdr(fd);
> @@ -843,6 +849,13 @@ int net_init_tap(const Netdev *netdev, const char *name,
>                  goto free_fail;
>              }
>  
> +            /* Check if fd is valid */
> +            if (!qemu_fd_is_valid(fd)) {
> +                error_setg(errp, "Invalid file descriptor %d", fd);
> +                ret = -1;
> +                goto free_fail;
> +            }
> +
>              qemu_set_nonblock(fd);
>  
>              if (i == 0) {
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 916f1be2243a..8d5705f598d3 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -244,6 +244,11 @@ void qemu_anon_ram_free(void *ptr, size_t size)
>      qemu_ram_munmap(-1, ptr, size);
>  }
>  
> +bool qemu_fd_is_valid(int fd)
> +{
> +    return fcntl(fd, F_GETFL) != -1;
> +}
> +
>  void qemu_set_block(int fd)
>  {
>      int f;
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index e9b14ab17847..a6be9445cfdb 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -132,6 +132,12 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
>  }
>  #endif /* CONFIG_LOCALTIME_R */
>  
> +bool qemu_fd_is_valid(int fd)
> +{
> +    /* FIXME: how to check if fd is valid? */
> +    return true;
> +}
> +

Maybe the following ?

bool qemu_fd_is_valid(int fd)
{
    return _get_osfhandle(fd) != INVALID_HANDLE_VALUE;
}

https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/get-osfhandle?view=vs-2019

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

>  void qemu_set_block(int fd)
>  {
>      unsigned long opt = 0;


