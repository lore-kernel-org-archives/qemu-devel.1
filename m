Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D748C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F9120848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F9120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRBlw-0004PJ-DE
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 04:29:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hRBlG-00047w-1g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1hRBlE-0005uX-Or
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hRBlE-0005sU-JI
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4A5E30BB523
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:29:06 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 20B665D9C3;
	Thu, 16 May 2019 08:29:05 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190311220843.4026-1-armbru@redhat.com>
	<20190311220843.4026-23-armbru@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <76d4a7b2-3c13-beea-2dc0-4fda7025030b@redhat.com>
Date: Thu, 16 May 2019 10:29:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190311220843.4026-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 16 May 2019 08:29:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 22/27] vl: Create block backends before
 setting machine properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/11/19 11:08 PM, Markus Armbruster wrote:
> qemu-system-FOO's main() acts on command line arguments in its own
> idiosyncratic order.  There's not much method to its madness.
> Whenever we find a case where one kind of command line argument needs
> to refer to something created for another kind later, we rejigger the
> order.
>=20
> Block devices get created long after machine properties get processed.
> Therefore, block device machine properties can be created, but not
> set.  No such properties exist.  But the next commit will create some.
> Time to rejigger again: create block devices earlier.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190308131445.17502-8-armbru@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   vl.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index c22ca447fa..e9239d55ad 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4274,6 +4274,13 @@ int main(int argc, char **argv, char **envp)
>           exit(0);
>       }
>  =20
> +    /*
> +     * Note: we need to create block backends before
> +     * machine_set_property(), so machine properties can refer to
> +     * them.
> +     */
> +    configure_blockdev(&bdo_queue, machine_class, snapshot);
> +
>       machine_opts =3D qemu_get_machine_opts();
>       qemu_opt_foreach(machine_opts, machine_set_property, current_mach=
ine,
>                        &error_fatal);
> @@ -4400,8 +4407,6 @@ int main(int argc, char **argv, char **envp)
>       ram_mig_init();
>       dirty_bitmap_mig_init();
>  =20
> -    configure_blockdev(&bdo_queue, machine_class, snapshot);
> -
>       qemu_opts_foreach(qemu_find_opts("mon"),
>                         mon_init_func, NULL, &error_fatal);
>  =20
>=20

Actually, there is more problems with this. Trying to run a guest with=20
persistent reservations fails after this patch is applied (git bisect=20
points me to this commit). My command line is:

qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 \
-monitor stdio \
-object pr-manager-helper,id=3Dpr-helper0,path=3D/tmp/pr-helper0.sock
-drive=20
file=3D/dev/mapper/crypt,file.pr-manager=3Dpr-helper0,format=3Draw,if=3Dn=
one,id=3Ddrive-scsi0-0-0-2=20
\
-device=20
scsi-block,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D2,drive=3Ddrive-sc=
si0-0-0-2,id=3Dscsi0-0-0-2

Honestly, I have no idea how to fix it, so I'm just raising this issue=20
here. Do you want me to open a bug or something?

Thanks,
Michal

