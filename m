Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD4DC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE1D221F1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEMSFewr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE1D221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaf0-00085v-2U
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIada-0006Tu-Tf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIadY-0004cN-AZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPn5+uqUpbmcoJWdVCPS/WvOMyDDZbYaATK656tACZQ=;
 b=YEMSFewrnvV7URid2x9lhKaJ+JuGskYhPKem/ZBl6vxrSJ8Drkf99v2LzcNuZL9xM5Huqn
 udelgkazEsYorUVtav3/h0zSs1MpNFyHOOKpHnkFfOdIWQF7fH1hU5DIOZKVH3Eb9niEkj
 rgQMwHKlgxm3xBplMBCVHurKx182Skw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-YMGMW7hePfyi5jE0csnuZQ-1; Wed, 16 Sep 2020 12:50:23 -0400
X-MC-Unique: YMGMW7hePfyi5jE0csnuZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B7F80EFA4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:50:22 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 212FB100238C;
 Wed, 16 Sep 2020 16:50:15 +0000 (UTC)
Message-ID: <8f4e5ad1128b97cfb3821657e9ecaedca32045e6.camel@redhat.com>
Subject: [RFC DOCUMENT 05/12] kubevirt-and-kvm: Add Networking page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:50:13 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sbrivio@redhat.com, vromanso@redhat.com, alkaplan@redhat.com,
 rmohr@redhat.com, crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Networking.md

# Networking

## Problem description

Service meshes (such as [Istio][], [Linkerd][]) typically expect
application processes to run on the same physical host, usually in a
separate user namespace. Network namespaces might be used too, for
additional isolation. Network traffic to and from local processes is
monitored and proxied by redirection and observation of local
sockets. `iptables` and `nftables` (collectively referred to as the
`netfilter` framework) are the typical Linux facilities providing
classification and redirection of packets.

![containers][Networking-Containers]
*Service meshes with containers. Typical ingress path:
**1.** NIC driver queues buffers for IP processing
**2.** `netfilter` rules installed by *service mesh* redirect packets
       to proxy
**3.** IP receive path completes, L4 protocol handler invoked
**4.** TCP socket of proxy receives packets
**5.** proxy opens TCP socket towards application service
**6.** packets get TCP header, ready for classification
**7.** `netfilter` rules installed by service mesh forward request to
       service
**8.** local IP routing queues packets for TCP protocol handler
**9.** application process receives packets and handles request.
Egress path is conceptually symmetrical.*

If we move application processes to VMs, sockets and processes are
not visible anymore. All the traffic is typically forwarded via
interfaces operating at data link level. Socket redirection and port
mapping to local processes don't work.

![and now?][Networking-Challenge]
*Application process moved to VM:
**8.** IP layer enqueues packets to L2 interface towards application
**9.** `tap` driver forwards L2 packets to guest
**10.** packets are received on `virtio-net` ring buffer
**11.** guest driver queues buffers for IP processing
**12.** IP receive path completes, L4 protocol handler invoked
**13.** TCP socket of application receives packets and handles request.
**:warning: Proxy challenge**: the service mesh can't forward packets
to local sockets via `netfilter` rules. *Add-on* NAT rules might
conflict, as service meshes expect full control of the ruleset.
Socket monitoring and PID/UID classification isn't possible.*

## Existing solutions

Existing solutions typically implement a full TCP/IP stack, replaying
traffic on sockets local to the Pod of the service mesh. This creates
the illusion of application processes running on the same host,
eventually separated by user namespaces.

![slirp][Networking-Slirp]
*Existing solutions introduce a third TCP/IP stack:
**8.** local IP routing queues packets for TCP protocol handler
**9.** userspace implementation of TCP/IP stack receives packets on
       local socket, and
**10.** forwards L2 encapsulation to `tap` *QEMU* interface (socket
        back-end).*

While being almost transparent to the service mesh infrastructure,
this kind of solution comes with a number of downsides:

* three different TCP/IP stacks (guest, adaptation and host) need to
  be traversed for every service request. There are no chances to
  implement zero-copy mechanisms, and the amount of context switches
  increases dramatically
* addressing needs to be coordinated to create the pretense of
  consistent addresses and routes between guest and host
  environments. This typically needs a NAT with masquerading, or some
  form of packet bridging
* the traffic seen by the service mesh and observable externally is a
  distant replica of the packets forwarded to and from the guest
  environment:
  * TCP congestion windows and network buffering mechanisms in
    general operate differently from what would be naturally expected
    by the application
  * protocols carrying addressing information might pose additional
    challenges, as the applications don't see the same set of
    addresses and routes as they would if deployed with regular
    containers

## Experiments

![experiments: thin layer][Networking-Experiments-Thin-Layer]
*How can we improve on the existing solutions while maintaining
drop-in compatibility? A thin layer implements a TCP adaptation
and IP services.*

These are some directions we have been exploring so far:

* a thinner layer between guest and host, that only implements what's
  strictly needed to pretend processes are running locally. A further
  TCP/IP stack is not necessarily needed. Some sort of TCP adaptation
  is needed, however, if this layer (currently implemented as
  userspace process) runs without the `CAP_NET_RAW` capability: we
  can't create raw IP sockets on the Pod, and therefore need to map
  packets at layer 2 to layer 4 sockets offered by the host kernel
  * to avoid implementing an actual TCP/IP stack like the one
    offered by *libslirp*, we can align TCP parameters advertised
    towards the guest (MSS, congestion window) to the socket
    parameters provided by the host kernel, probing them via the
    `TCP_INFO` socket option (introduced in Linux 2.4).
    Segmentation and reassembly is therefore not needed, providing
    solid chances to avoid dynamic memory allocation altogether, and
    congestion control becomes implicitly equivalent as parameters
    are mirrored between the two sides
  * to reflect the actual receiving dynamic of the guest and support
    retransmissions without a permanent userspace buffer, segments
    are not dequeued (`MSG_PEEK`) until acknowledged by the receiver
    (application)
  * similarly, the implementation of the host-side sender adjusts MSS
    (`TCP_MAXSEG` socket option, since Linux 2.6.28) and advertised
    window (`TCP_WINDOW_CLAMP`, since Linux 2.4) to the parameters
    observed from incoming packets
  * this adaptation layer needs to maintain some of the TCP states,
    but we can rely on the host kernel TCP implementation for the
    different states of connections being closed
  * no particular requirements are placed on the MTU of guest
    interfaces: if fragments are received, payload from the single
    fragmented packets can be reassembled by the host kernel as
    needed, and out-of-order fragments can be safely discarded, as
    there's no intermediate hop justifying the condition
* this layer would connect to `qemu` over a *UNIX domain socket*,
  instead of a `tap` interface, so that the `CAP_NET_ADMIN`
  capability doesn't need to be granted to any process on the Pod:
  no further network interfaces are created on the host
* transparent, adaptive mapping of ports to the guest, to avoid the
  need for explicit port forwarding
* security and maintainability goals: no dynamic memory allocation,
  ~2 000 *LoC* target, no external dependencies

![experiments: ebpf][Networking-Experiments-eBPF]
*Additionally, an `eBPF` fast path could be implemented
**6.** hooking at socket level, and
**7.** mapping IP and Ethernet addresses,
with the existing layer implementing connection tracking and slow
path*

If additional capabilities are granted, the data path can be
optimised in several ways:

* with `CAP_NET_RAW`:
  * the adaptation layer can use raw IP sockets instead of L4 sockets,
    implementing a pure connection tracking, without the need for any
    TCP logic: the guest operating system implements the single TCP
    stack needed with this variation
  * zero-copy mechanisms could be implemented using `vhost-user` and
    QEMU socket back-ends, instead of relying on a full-fledged layer 2
    (Ethernet) interface
* with `CAP_BPF` and `CAP_NET_ADMIN`:
  * context switching in packet forwarding could be avoided by the
    `sockmap` extension provided by `eBPF`, and programming the `XDP`
    data hooks for in-kernel data transfers
  * using eBPF programs, we might want to switch (dynamically?) to
    the `vhost-net` facility
  * the userspace process would still need to take care of
    establishing in-kernel flows, and providing IP and IPv6
    services (ARP, DHCP, NDP) for addressing transparency and to
    avoid the need for further capabilities (e.g.
    `CAP_NET_BIND_SERVICE`), but the main, fast datapath would
    reside entirely in the kernel

[Istio]: https://istio.io/
[Linkerd]: https://linkerd.io/
[Networking-Challenge]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Networking-Challenge.png
[Networking-Containers]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Networking-Containers.png
[Networking-Experiments-Thin-Layer]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Networking-Experiments-Thin-Layer.png
[Networking-Experiments-eBPF]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Networking-Experiments-eBPF.png
[Networking-Slirp]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Networking-Slirp.png


