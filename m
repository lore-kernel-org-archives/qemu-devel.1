Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF3C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 22:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D13D20719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 22:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaTPUq2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D13D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJlR9-0003xI-Kb
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 18:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJlQL-0003WN-27
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJlQI-0006ii-Dl
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:01:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJlQI-0006h8-6p
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585778481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAJ6YAbrayHj0/c7RFCQ6/a0KxkFqICayrajrXm+VAA=;
 b=VaTPUq2XcgEjy4Z1x1QNOxnboVCuwqOzr3wrGszNdn+hjq8GjZv7Yw8PHR6aMWEJvpUrBT
 gqb4tnbOst5WyEg6wVuXBxtjN2pU9D3+Qm9YE9+K8v8uU3QzgZn4nrLsHxFpNfxR0HzqUl
 O3Kov44vNFZbH2lI4Bc4dwPvP3jS1wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-GXa2GbOkMxKvN7U-TJjR6A-1; Wed, 01 Apr 2020 18:01:17 -0400
X-MC-Unique: GXa2GbOkMxKvN7U-TJjR6A-1
Received: by mail-wm1-f70.google.com with SMTP id w8so530241wmk.5
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 15:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w1SRj9z5+6BmrmQghqPvCkwm56zWaRADGFJ8WUV505Y=;
 b=JlvoCiWk4KmKx0sjWfgRZNyiStAnQ86Xf6+O4KRlZzgw/pVXyEfWtvVHJCod/FsQsU
 bHNaxQOFw/i1EkV9tIbr3JC+PDf/sCyo0Djw97vdAdPLcny1FNY5j1FqyzEZ1DSWBYth
 TTNFpytwodsRMpdUiVu3G5TBwBIQgspIE2tOIvoI6cX4UYmci8lmhOZRKFStTjIqciON
 6PWxWlTuBzAqb7lSLyx9WxkbkZ0z7I7S9tZKDfGhe2zgnrtUgR6DLrHvtAyYydPehuuc
 e5Z8Sa6fIFN07fRfQqBQD2uWkOVND9cE95l52z1d/pxewYmslcy43hLrvhTn6qB6lfVB
 k5sg==
X-Gm-Message-State: AGi0PuaOMmvSqMZ5mCwOkSl/uSxUJYc8CcnjCdWsNLa4wVVZvOgSLGzV
 wrG4racuB/hNbu+dCWWOuPD8n8fHdRRrBwEZ5AyR2CXUVxVnE4294KsKfwDq10MD7TsL5VB4Nzh
 g6sl/7maa8TfexlA=
X-Received: by 2002:a7b:c3cb:: with SMTP id t11mr127556wmj.40.1585778475999;
 Wed, 01 Apr 2020 15:01:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRYGoHB4f59eNQpx7SZ48zPxVShKPALTMeSem8txsvb0QvCQm14QxUGMXkKDyDe6+UAlIlrw==
X-Received: by 2002:a7b:c3cb:: with SMTP id t11mr127529wmj.40.1585778475745;
 Wed, 01 Apr 2020 15:01:15 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n11sm4072565wmi.10.2020.04.01.15.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 15:01:15 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: Willian Rampazzo <wrampazz@redhat.com>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
 <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
 <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
 <96219ba3-c114-0cec-8ace-bc19b254077a@redhat.com>
 <CAKJDGDbXeDrDWgxoZ=+LwPmexestnXJxqD5Mcrq9C4Aiy9x3dg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d52e1d9d-f892-f760-6bca-e37689cff362@redhat.com>
Date: Thu, 2 Apr 2020 00:01:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKJDGDbXeDrDWgxoZ=+LwPmexestnXJxqD5Mcrq9C4Aiy9x3dg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/1/20 10:30 PM, Willian Rampazzo wrote:
> On Wed, Apr 1, 2020 at 5:21 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>   <snip>
>> Odd, with avocado-framework=3D=3D76.0 I get:
>>
>> https://travis-ci.org/github/philmd/qemu/jobs/669851870#L4908
>>
>> Traceback (most recent call last):
>>     File "/usr/lib/python3.6/runpy.py", line 193, in _run_module_as_main
>>       "__main__", mod_spec)
>>     File "/usr/lib/python3.6/runpy.py", line 85, in _run_code
>>       exec(code, run_globals)
>>     File
>> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6zsite-pack=
ages/avocado/__main__.py",
>> line 11, in <module>
>>       sys.exit(main.run())
>>     File
>> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-pack=
ages/avocado/core/app.py",
>> line 91, in run
>>       return method(self.parser.config)
>>     File
>> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-pack=
ages/avocado/plugins/assets.py",
>> line 291, in run
>>       success, fail =3D fetch_assets(test_file)
>>     File
>> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-pack=
ages/avocado/plugins/assets.py",
>> line 200, in fetch_assets
>>       handler =3D FetchAssetHandler(test_file, klass, method)
>>     File
>> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-pack=
ages/avocado/plugins/assets.py",
>> line 65, in __init__
>>       self.visit(self.tree)
>>     File "/usr/lib/python3.6/ast.py", line 253, in visit
>>       return visitor(node)
>>     File "/usr/lib/python3.6/ast.py", line 261, in generic_visit
>>       self.visit(item)
>>     File "/usr/lib/python3.6/ast.py", line 253, in visit
>>       return visitor(node)
>>     File
>> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-pack=
ages/avocado/plugins/assets.py",
>> line 139, in visit_ClassDef
>>       self.generic_visit(node)
>>     File "/usr/lib/python3.6/ast.py", line 261, in generic_visit
>>       self.visit(item)
>>     File "/usr/lib/python3.6/ast.py", line 253, in visit
>>       return visitor(node)
>>     File
>> "/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-pack=
ages/avocado/plugins/assets.py",
>> line 171, in visit_Assign
>>       self.asgmts[cur_klass][cur_method][name] =3D node.value.s
>> KeyError: 'launch_and_wait'
>> /home/travis/build/philmd/qemu/tests/Makefile.include:910: recipe for
>> target 'fetch-acceptance-assets' failed
>>
>> This launch_and_wait comes from:
>>
>> tests/acceptance/boot_linux.py:88:    def launch_and_wait(self):
>=20
> Sorry about that. This is a known bug, see
> https://github.com/avocado-framework/avocado/issues/3661. It is fixed
> upstream and will be available in the next release of Avocado.

Thanks for the quick reply :)

I'm now using this kludge to include your bugfix:

-- >8 --
diff --git a/tests/requirements.txt b/tests/requirements.txt
index f9c84b4ba1..d625b32dbb 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,5 +1,5 @@
  # Add Python module requirements, one per line, to be installed
  # in the tests/venv Python virtual environment. For more info,
  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D76.0
+-e=20
git+https://github.com/avocado-framework/avocado.git@f9b4dc7c58a6424eb8d0ed=
6781a1d76ae3a5ab06#egg=3Davocado-framework
  pycdlib=3D=3D1.9.0
---

But I'm getting another error:

https://travis-ci.org/github/philmd/qemu/builds/669898682#L1702

...
avocado.test: Asset not in cache, fetching it.
avocado.test: Fetching=20
ftp://ftp.boulder.ibm.com/rs6000/firmware/7020-40p/P12H0456.IMG ->=20
/home/travis/avocado/data/cache/by_location/9234e55550fdde347e2a4604c133fa2=
c8d9e9291/P12H0456.IMG.dp3lw27q
avocado.test: FileNotFoundError: [Errno 2] No such file or directory:=20
'/home/travis/avocado/data/cache/by_location/9234e55550fdde347e2a4604c133fa=
2c8d9e9291/P12H0456.IMG.dp3lw27q'
Failed to fetch P12H0456.IMG.
/home/travis/build/philmd/qemu/tests/Makefile.include:910: recipe for=20
target 'fetch-acceptance-assets' failed
make: *** [fetch-acceptance-assets] Error 4

I don't understand because all the other directories are created, I'm=20
not sure what is missing here, any idea?

(test branch is https://github.com/philmd/qemu/commits/travis_fetch_avocado=
)

Thanks,

Phil.


