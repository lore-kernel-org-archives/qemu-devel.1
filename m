Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBAAC04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E0E2089E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E0E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hREob-0007bT-3Z
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 07:44:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hREn7-0006iM-SM
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hREn6-00013i-P9
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hREn6-00011p-HO
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:43:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E04077FDF4
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 11:43:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B022260DDD;
	Thu, 16 May 2019 11:43:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 56D8D11385E4; Thu, 16 May 2019 13:43:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
	<20190311220843.4026-23-armbru@redhat.com>
	<76d4a7b2-3c13-beea-2dc0-4fda7025030b@redhat.com>
Date: Thu, 16 May 2019 13:43:13 +0200
In-Reply-To: <76d4a7b2-3c13-beea-2dc0-4fda7025030b@redhat.com> (Michal
	Privoznik's message of "Thu, 16 May 2019 10:29:04 +0200")
Message-ID: <878sv6tyjy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 16 May 2019 11:43:15 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michal Privoznik <mprivozn@redhat.com> writes:

> On 3/11/19 11:08 PM, Markus Armbruster wrote:
>> qemu-system-FOO's main() acts on command line arguments in its own
>> idiosyncratic order.  There's not much method to its madness.
>> Whenever we find a case where one kind of command line argument needs
>> to refer to something created for another kind later, we rejigger the
>> order.
>>
>> Block devices get created long after machine properties get processed.
>> Therefore, block device machine properties can be created, but not
>> set.  No such properties exist.  But the next commit will create some.
>> Time to rejigger again: create block devices earlier.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Message-Id: <20190308131445.17502-8-armbru@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   vl.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index c22ca447fa..e9239d55ad 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4274,6 +4274,13 @@ int main(int argc, char **argv, char **envp)
>>           exit(0);
>>       }
>>   +    /*
>> +     * Note: we need to create block backends before
>> +     * machine_set_property(), so machine properties can refer to
>> +     * them.
>> +     */
>> +    configure_blockdev(&bdo_queue, machine_class, snapshot);
>> +
>>       machine_opts =3D qemu_get_machine_opts();
>>       qemu_opt_foreach(machine_opts, machine_set_property, current_machi=
ne,
>>                        &error_fatal);
>> @@ -4400,8 +4407,6 @@ int main(int argc, char **argv, char **envp)
>>       ram_mig_init();
>>       dirty_bitmap_mig_init();
>>   -    configure_blockdev(&bdo_queue, machine_class, snapshot);
>> -
>>       qemu_opts_foreach(qemu_find_opts("mon"),
>>                         mon_init_func, NULL, &error_fatal);
>>=20=20=20
>>
>
> Actually, there is more problems with this. Trying to run a guest with
> persistent reservations fails after this patch is applied (git bisect
> points me to this commit). My command line is:
>
> qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 \
> -monitor stdio \
> -object pr-manager-helper,id=3Dpr-helper0,path=3D/tmp/pr-helper0.sock
> -drive
> file=3D/dev/mapper/crypt,file.pr-manager=3Dpr-helper0,format=3Draw,if=3Dn=
one,id=3Ddrive-scsi0-0-0-2=20
> \
> -device
> scsi-block,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D2,drive=3Ddrive-sc=
si0-0-0-2,id=3Dscsi0-0-0-2
>
> Honestly, I have no idea how to fix it, so I'm just raising this issue
> here. Do you want me to open a bug or something?

Let's skip the bug filing bureaucracy and go straight to debugging.

Actual and expected behavior of your reproducer, please :)

