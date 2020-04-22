Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4559C5518B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33E320774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAzlDUUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33E320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHvk-0006dN-Sl
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRHuD-0005Fn-6E
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRHuC-0002X8-8c
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:07:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRHuB-0002Uf-RL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587571638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TS42zkEFD9MPLtoabZdAfk7BbLTxXYVeYdDeJyaw8b4=;
 b=VAzlDUUeWGA/yCmrjzX+8Xi0nGpS6CVrHR7il8ChbdR/ywkitXie7/4YwMgFV3wK46/SbV
 myXrMuhKYIgMbYFlVSwgC40+eH3qYARm+/uG8++NMH0vbDNHyd1r2ZQW3lNntjiMw9dlJx
 oTfcIWodBsGZC84cdzLXzBVO78SQOQ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-avty3GKSNTWclZOBPNGVvw-1; Wed, 22 Apr 2020 12:07:15 -0400
X-MC-Unique: avty3GKSNTWclZOBPNGVvw-1
Received: by mail-wr1-f72.google.com with SMTP id j16so1267048wrw.20
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SFyGl6ZxHrzwcX5Pr/G7aRSbIdQMdMe0LW144w9zs04=;
 b=F8hmS60lNESksLA5sAGcSLJCfo7ClSI5Q2hNCazZuUgxaAvbsF6TlKTJwJEtZeHsRg
 9JKpw/S7YU/984XMch4Qx1kWwBfrwjtK0Pu+ROfkpCPjDANTL6CvbQm9UMis4AfXptsH
 W40B1MDDP2sz4SF+8OU25NGjaXrg6LGsIlTFlCriPI/EloxHqOx5y5bimaHo5Oa+Z/DJ
 f1ANDzevxbfGv7YbrBkcw56bLQejFbwBaQCERp+cVcACdrd3abEQ2S0c93yj5H1FTXH0
 pUimqs8oQFTM2FueWKZw5ujmQ+DNR3nO/7EjeP1fMcCNSJ2z2XyHJYb65kJDveKPQeY8
 MRPw==
X-Gm-Message-State: AGi0PubJR18EtbSICiDeMsv87NyLNMpzpl8qCSVj8rWR9L4og+NWEvyP
 2PborzZd1FXEP8XIWKcAIu2Tal9Ezeqbd7zcH9S64awmmfMzNiCbc4DzFGJg2PJsI3cyv9LxLKe
 GU7vOk4pVXX+ILxw=
X-Received: by 2002:a5d:4cc2:: with SMTP id c2mr13377567wrt.130.1587571633772; 
 Wed, 22 Apr 2020 09:07:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypLV0fdqcgyl9DbTuqcPzgMvu+4+L1tsYDyCrmThVFbSHQAG1rIOHE+OpVJx7wzBcMMGVihYRQ==
X-Received: by 2002:a5d:4cc2:: with SMTP id c2mr13377549wrt.130.1587571633549; 
 Wed, 22 Apr 2020 09:07:13 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm8059837wma.47.2020.04.22.09.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 09:07:09 -0700 (PDT)
Subject: Re: [PATCH v2 14/14] qga: Fix qmp_guest_suspend_{disk, ram}() error
 handling
To: Markus Armbruster <armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-15-armbru@redhat.com>
 <ccf97c71-744d-1d0a-f961-bb3d71c1c64a@redhat.com>
 <87zhb3v9c4.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0cabb08f-b53a-ac6b-bd14-1aed2b88e848@redhat.com>
Date: Wed, 22 Apr 2020 18:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zhb3v9c4.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 5:17 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 4/22/20 3:07 PM, Markus Armbruster wrote:
>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>> pointer to a variable containing NULL.  Passing an argument of the
>>> latter kind twice without clearing it in between is wrong: if the
>>> first call sets an error, it no longer points to NULL for the second
>>>
>>> qmp_guest_suspend_disk() and qmp_guest_suspend_ram() pass @local_err
>>> first to check_suspend_mode(), then to acquire_privilege(), then to
>>> execute_async().  Continuing after errors here can only end in tears.
>>> For instance, we risk tripping error_setv()'s assertion.
>>>
>>> Fixes: aa59637ea1c6a4c83430933f9c44c43e6c3f1b69
>>> Fixes: f54603b6aa765514b2519e74114a2f417759d727
>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    qga/commands-win32.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>>> index 9717a8d52d..5ba56327dd 100644
>>> --- a/qga/commands-win32.c
>>> +++ b/qga/commands-win32.c
>>> @@ -1322,9 +1322,16 @@ void qmp_guest_suspend_disk(Error **errp)
>>>          *mode =3D GUEST_SUSPEND_MODE_DISK;
>>>        check_suspend_mode(*mode, &local_err);
>>> +    if (local_err) {
>>> +        goto out;
>>> +    }
>>>        acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
>>> +    if (local_err) {
>>> +        goto out;
>>> +    }
>>>        execute_async(do_suspend, mode, &local_err);
>>>    +out:
>>>        if (local_err) {
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg695647.html is
>> slightly different by removing the if() check.
>=20
> It frees @mode unconditionally (marked --> below) I believe that's
> wrong.  execute_async() runs do_suspend() in a new thread, and passes it
> @mode.  do_suspend() frees it.

Oops I missed that, good catch!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
>>>            error_propagate(errp, local_err);
>>>            g_free(mode);
>>> @@ -1338,9 +1345,16 @@ void qmp_guest_suspend_ram(Error **errp)
>>>          *mode =3D GUEST_SUSPEND_MODE_RAM;
>>>        check_suspend_mode(*mode, &local_err);
>>> +    if (local_err) {
>>> +        goto out;
>>> +    }
>>>        acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
>>> +    if (local_err) {
>>> +        goto out;
>>> +    }
>>>        execute_async(do_suspend, mode, &local_err);
>>>    +out:
>>>        if (local_err) {
>>>            error_propagate(errp, local_err);
>>>            g_free(mode);
>>>
>=20
>     diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>     index b49920e201..8b66098056 100644
>     --- a/qga/commands-win32.c
>     +++ b/qga/commands-win32.c
>     @@ -1341,13 +1341,18 @@ void qmp_guest_suspend_disk(Error **errp)
>=20
>          *mode =3D GUEST_SUSPEND_MODE_DISK;
>          check_suspend_mode(*mode, &local_err);
>     +    if (local_err) {
>     +        goto out;
>     +    }
>          acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
>     +    if (local_err) {
>     +        goto out;
>     +    }
>          execute_async(do_suspend, mode, &local_err);
>=20
>     -    if (local_err) {
>     -        error_propagate(errp, local_err);
>     -        g_free(mode);
>     -    }
>     +out:
>     +    error_propagate(errp, local_err);
> -->+    g_free(mode);
>      }
>=20
>      void qmp_guest_suspend_ram(Error **errp)
>=20


