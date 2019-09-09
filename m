Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C2C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3583320674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3583320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Fkm-0000QU-8d
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i7Fjp-00082P-9D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i7Fjn-0001bI-Ma
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i7Fji-0001YK-Gn; Mon, 09 Sep 2019 05:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2964D30A5411;
 Mon,  9 Sep 2019 09:13:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5618E100197A;
 Mon,  9 Sep 2019 09:13:24 +0000 (UTC)
Date: Mon, 9 Sep 2019 10:13:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190909091322.GA24509@redhat.com>
References: <20190907172055.26870-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907172055.26870-1-eblake@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 09 Sep 2019 09:13:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/client: Add hint when TLS is missing
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Tingting Mao <timao@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 07, 2019 at 12:20:55PM -0500, Eric Blake wrote:
> I received an off-list report of failure to connect to an NBD server
> expecting an x509 certificate, when the client was attempting something
> similar to this command line:
>=20
> $ ./x86_64-softmmu/qemu-system-x86_64 -name 'blah' -machine q35 -nodefa=
ults \
>   -object tls-creds-x509,id=3Dtls0,endpoint=3Dclient,dir=3D$path_to_cer=
ts \
>   -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0,bus=3Dpcie.0,addr=3D0x6=
 \
>   -drive id=3Ddrive_image1,if=3Dnone,snapshot=3Doff,aio=3Dthreads,cache=
=3Dnone,format=3Draw,file=3Dnbd:localhost:9000,werror=3Dstop,rerror=3Dsto=
p,tls-creds=3Dtls0 \
>   -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D0
> qemu-system-x86_64: -drive id=3Ddrive_image1,if=3Dnone,snapshot=3Doff,a=
io=3Dthreads,cache=3Dnone,format=3Draw,file=3Dnbd:localhost:9000,werror=3D=
stop,rerror=3Dstop,tls-creds=3Dtls0: TLS negotiation required before opti=
on 7 (go)
> server reported: Option 0x7 not permitted before TLS
>=20
> The problem?  As specified, -drive is trying to pass tls-creds to the
> raw format driver instead of the nbd protocol driver, but before we
> get to the point where we can detect that raw doesn't know what to do
> with tls-creds, the nbd driver has already failed because the server
> complained.  The fix to the broken command line?  Pass
> '...,file.tls-creds=3Dtls0' to ensure the tls-creds option is handed to
> nbd, not raw.  But since the error message was rather cryptic, I'm
> trying to improve the error message.
>=20
> With this patch, the error message adds a line:
>=20
> qemu-system-x86_64: -drive id=3Ddrive_image1,if=3Dnone,snapshot=3Doff,a=
io=3Dthreads,cache=3Dnone,format=3Draw,file=3Dnbd:localhost:9000,werror=3D=
stop,rerror=3Dstop,tls-creds=3Dtls0: TLS negotiation required before opti=
on 7 (go)
> Did you forget a valid tls-creds?
> server reported: Option 0x7 not permitted before TLS
>=20
> And with luck, someone grepping for that error message will find this
> commit message and figure out their command line mistake.  Sadly, the
> only mention of file.tls-creds in our docs relates to an --image-opts
> use of PSK encryption with qemu-img as the client, rather than x509
> certificate encryption with qemu-kvm as the client.
>=20
> CC: Tingting Mao <timao@redhat.com>
> CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index b9dc829175f9..f6733962b49b 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -204,6 +204,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NB=
DOptionReply *reply,
>      case NBD_REP_ERR_TLS_REQD:
>          error_setg(errp, "TLS negotiation required before option %" PR=
Iu32
>                     " (%s)", reply->option, nbd_opt_lookup(reply->optio=
n));
> +        error_append_hint(errp, "Did you forget a valid tls-creds?\n")=
;
>          break;
>=20
>      case NBD_REP_ERR_UNKNOWN:

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

