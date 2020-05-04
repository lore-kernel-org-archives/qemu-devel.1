Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A64C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884B9206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOTgtTWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884B9206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcPB-00065g-Ks
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVc7m-00009f-Vq
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:31:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45804
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVc7l-0007Um-HT
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eu9htyrJv2NAWcCAcdInUX/MuthC+9eSfuWwdLPoWOA=;
 b=EOTgtTWgpJaQ8xHpc71Hyk8pdekD+tiUHlFTU5OJOkCES/juRPBLe7sSmVSdYq1ESFNrXe
 l2AFf4xyklqMQuVFisub7TuFy9n9LyYriww4+JK1efD8rU21OLC35qwSG3cZv2xv+CX8Vp
 ogEXaxMaKFnRIJbhTS9yvVGWzi0bu+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-qm9dzRLNP1y9zcJ__JhLdw-1; Mon, 04 May 2020 10:31:11 -0400
X-MC-Unique: qm9dzRLNP1y9zcJ__JhLdw-1
Received: by mail-wr1-f69.google.com with SMTP id y4so5806285wrt.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aKs8Xfgzaqa1KeQHto6nIWvDT/l0FTKC+EnAyTmz1lo=;
 b=geA2FQbK9M1qPDc8cy2/BO1Cfe5byt0dpbCfca5EVSGIAGY+uHPes80I9TZ+8JqPjD
 TpyWvMXxLOc+tsK3K/3/06O8BuiIaT4BQE/j5sqAkmFiYalwSTHVOFqtcvmwbHMi8yI+
 HTTBjr0R32OYr5SKzvozxuRRzEMFBKvHpGmkTeZHrDRQMfIUIlKBgeoocHE4yV/H9PhP
 /Lx9FwtQSMnQQQ6G+eN7iTxr+KXDrFdyxf5adLqua5cwq0rTjbS6CjavJWqN6XLNjj8k
 qFLV1zhiwhxE1hamGXEJrPAaB/U+yLsH+40hdmlsGdMI87tycukS0J2x1Sou91rviUX5
 ghqA==
X-Gm-Message-State: AGi0PuaFxsgZuqnZAVZb6roSKmLy+DazFZELDXY8bR5zCB+kDukCR7R5
 tgvyvQJ0uTHddJEyZXCFelCX5H3a84QW6CLpHaa0rahFHeKCu29363lGVrTB/Iucl5cUT3bBt87
 1MDskegZ0zHvQVnE=
X-Received: by 2002:a1c:e444:: with SMTP id b65mr15796761wmh.6.1588602669637; 
 Mon, 04 May 2020 07:31:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ6n5p5Q1M4KALplm0OooJKabwclL2JhtPLkz/0NiYT2q9RWpD/3+Qp4v007/MAI8i38fsGyQ==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr15796744wmh.6.1588602669423; 
 Mon, 04 May 2020 07:31:09 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id p190sm14089130wmp.38.2020.05.04.07.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:31:08 -0700 (PDT)
Subject: Re: [PATCH] hostmem: don't use mbind() if host-nodes is epmty
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20200430154606.6421-1-imammedo@redhat.com>
 <20200501085708.GA2203114@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e8aabda-9dd0-3300-04e6-81761ef3a837@redhat.com>
Date: Mon, 4 May 2020 16:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200501085708.GA2203114@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, mhohmann@physnet.uni-hamburg.de,
 qemu-stable@nongnu.org, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 10:57 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Apr 30, 2020 at 11:46:06AM -0400, Igor Mammedov wrote:
>> Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
>> The backend however calls mbind() which is typically NOP
>> in case of default policy/absent host-nodes bitmap.
>> However when runing in container with black-listed mbind()
>> syscall, QEMU fails to start with error
>>   "cannot bind memory to host NUMA nodes: Operation not permitted"
>> even when user hasn't provided host-nodes to pin to explictly
>> (which is the case with -m option)
>>
>> To fix issue, call mbind() only in case when user has provided
>> host-nodes explicitly (i.e. host_nodes bitmap is not empty).
>> That should allow to run QEMU in containers with black-listed
>> mbind() without memory pinning. If QEMU provided memory-pinning
>> is required user still has to white-list mbind() in container
>> configuration.
>>
>> Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> CC: berrange@redhat.com
>> CC: ehabkost@redhat.com
>> CC: pbonzini@redhat.com
>> CC: mhohmann@physnet.uni-hamburg.de
>> CC: qemu-stable@nongnu.org
>> ---
>>   backends/hostmem.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>> index 327f9eebc3..0efd7b7bd6 100644
>> --- a/backends/hostmem.c
>> +++ b/backends/hostmem.c
>> @@ -383,8 +383,10 @@ host_memory_backend_memory_complete(UserCreatable *=
uc, Error **errp)
>>           assert(sizeof(backend->host_nodes) >=3D
>>                  BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
>>           assert(maxnode <=3D MAX_NODES);
>> -        if (mbind(ptr, sz, backend->policy,
>> -                  maxnode ? backend->host_nodes : NULL, maxnode + 1, fl=
ags)) {
>> +
>> +        if (maxnode &&
>> +            mbind(ptr, sz, backend->policy, backend->host_nodes, maxnod=
e + 1,
>> +                  flags)) {
>>               if (backend->policy !=3D MPOL_DEFAULT || errno !=3D ENOSYS=
) {
>>                   error_setg_errno(errp, errno,
>>                                    "cannot bind memory to host NUMA node=
s");
>=20
> personally I would have found this code clearer if the
> check had been  "if (backend->policy !=3D MPOL_DEFAULT && ..."
> as I had to read quite a few lines to understand that the
> 'maxnode' is zero if-and-only-if  policy =3D=3D MPOL_DEFAULT
>=20
> Regardless though, this is functionally correct so
>=20
>     Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I could reproduce running 'make check-qtest-hppa' on the qemu:fedora image:

   TEST    check-qtest-hppa: tests/qtest/boot-serial-test
qemu-system-hppa: cannot bind memory to host NUMA nodes: Operation not=20
permitted
Broken pipe
tests/qtest/libqtest.c:166: kill_qemu() tried to terminate QEMU process=20
but encountered exit status 1 (expected 0)
ERROR - too few tests run (expected 1, got 0)
make: *** [tests/Makefile.include:637: check-qtest-hppa] Error 1

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Regards,
> Daniel
>=20


