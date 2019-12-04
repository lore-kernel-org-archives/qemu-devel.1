Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5122C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FAB20661
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boPBk7Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FAB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icOVz-0002PO-OR
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 01:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1icOTK-0001Mh-N2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1icOTG-00031l-Uo
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:49:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52175
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1icOTA-0002vf-PE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575442136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=la7e7hR09dcEK4j7C1iBNGwb6oDApSdrHNvKiSNkA/M=;
 b=boPBk7PjZZFSp36T5mPOdq5tpzg2CSokECNBHVgVS+tO+/oAeQNFx0x3HnNTiX/EujlpBf
 NeP0woo/wbS6irupM+PjiITjKaJ7elFb5GLHVQhgUlXlVlG45HBWFVYfICMv5ncELAvMjm
 sZAuzIh7WDHq+W4yCNxfM3GarllRnls=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-_13z91WoNMGRR-o9z6coJQ-1; Wed, 04 Dec 2019 01:48:55 -0500
Received: by mail-ot1-f69.google.com with SMTP id m26so2862240otk.12
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 22:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5K+z10WJPcVEYYNkRRpjbQI0xD/MXowcCp5XmpINRQI=;
 b=nHryqx60+/bCDw3rjztYyYF50ODvKj/2HZF0y2ttJhvu9FTO8Wf7LhdGIALIFcnf+R
 tHdaikw//AzWDX/nuklXfKsjCjJIW/mcV5ILc00QKIlNxYtbYEATdYSTmxEo+cHS0G7W
 1gKg5qFAuaGZbUz4ySVpIWPd+xd3sYUDfWZ74J9a3B2thdfNwHZ8fgPrK2mqUkardEWT
 AIVVreJXQC3aRQVtWjHPjcj95rV8uh/zMKhZnHxOGWPiaWQUgAdL50gko+woEzU3eQUn
 +q5xnOjguJJpw6A+eWGJKQ3caQfkxwb8hYz9iOaH0wGClofw4DjdIKCuhug9K47uaF4M
 FBcw==
X-Gm-Message-State: APjAAAUozRNMNJifi1MsVqLeEYuMw5BbqPoYwxr9e9CrPtuxYHxrc7mf
 cVnSHy0DpvuwEo7OTI+GrMHLQ5/8y7zR9W31jgMA8k7JrsxSK8al3iIU36zUzcVZtsi2rEXjdbs
 OPjfaoMzwC8ShZEhD+HeuIsOgOSHpFqY=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr1472493otk.14.1575442134419; 
 Tue, 03 Dec 2019 22:48:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxPl4zVANBxfbfrpmnlLkOS15+oeQGFzNQ5KPhMWu/DzJQDVwZNjhTFuIFkWV+NAEiJaa7vCRcsdD1OMbS19A=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr1472482otk.14.1575442134156; 
 Tue, 03 Dec 2019 22:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20191113131655.307847-1-hhan@redhat.com>
 <CAHjf+S_miSm8ygAadObVnif1LKejA=j9OFae+OV5Oe-TedByyQ@mail.gmail.com>
In-Reply-To: <CAHjf+S_miSm8ygAadObVnif1LKejA=j9OFae+OV5Oe-TedByyQ@mail.gmail.com>
From: Han Han <hhan@redhat.com>
Date: Wed, 4 Dec 2019 14:48:01 +0800
Message-ID: <CAHjf+S8LVAMjuvXNhE5MyAirpFE7NgUsn6YDHX7yLPgK4brW2g@mail.gmail.com>
Subject: Re: [PATCH] scripts: Fix undefinited name 'file' error for python3
To: qemu-trivial@nongnu.org
X-MC-Unique: _13z91WoNMGRR-o9z6coJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000c55f7d0598db3478"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c55f7d0598db3478
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Anyone help to review it?

On Tue, Nov 26, 2019 at 1:54 PM Han Han <hhan@redhat.com> wrote:

> ping
>
> On Wed, Nov 13, 2019 at 9:17 PM Han Han <hhan@redhat.com> wrote:
>
>> In python3, 'file' is no longer a keyword for file type object. So it
>> will can error when run the scripts by python3:
>>
>> $ python3 ./scripts/vmstate-static-checker.py -s 4.0.json -d 4.1.json
>> Traceback (most recent call last):
>>   File "./scripts/vmstate-static-checker.py", line 431, in <module>
>>     sys.exit(main())
>>   File "./scripts/vmstate-static-checker.py", line 378, in main
>>     parser.add_argument('-s', '--src', type=3Dfile, required=3DTrue,
>> NameError: name 'file' is not defined
>>
>> Replace file type to argparse.FileType('r').
>>
>> Signed-off-by: Han Han <hhan@redhat.com>
>> ---
>>  scripts/vmstate-static-checker.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/vmstate-static-checker.py
>> b/scripts/vmstate-static-checker.py
>> index d3467288..14f199a0 100755
>> --- a/scripts/vmstate-static-checker.py
>> +++ b/scripts/vmstate-static-checker.py
>> @@ -375,9 +375,9 @@ def main():
>>      help_text =3D "Parse JSON-formatted vmstate dumps from QEMU in file=
s
>> SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions
>> would break based on the VMSTATE information contained within the JSON
>> outputs.  The JSON output is created from a QEMU invocation with the
>> -dump-vmstate parameter and a filename argument to it.  Other parameters=
 to
>> QEMU do not matter, except the -M (machine type) parameter."
>>
>>      parser =3D argparse.ArgumentParser(description=3Dhelp_text)
>> -    parser.add_argument('-s', '--src', type=3Dfile, required=3DTrue,
>> +    parser.add_argument('-s', '--src', type=3Dargparse.FileType('r'),
>> required=3DTrue,
>>                          help=3D'json dump from src qemu')
>> -    parser.add_argument('-d', '--dest', type=3Dfile, required=3DTrue,
>> +    parser.add_argument('-d', '--dest', type=3Dargparse.FileType('r'),
>> required=3DTrue,
>>                          help=3D'json dump from dest qemu')
>>      parser.add_argument('--reverse', required=3DFalse, default=3DFalse,
>>                          action=3D'store_true',
>> --
>> 2.23.0
>>
>>
>
> --
> Best regards,
> -----------------------------------
> Han Han
> Quality Engineer
> Redhat.
>
> Email: hhan@redhat.com
> Phone: +861065339333
>


--=20
Best regards,
-----------------------------------
Han Han
Quality Engineer
Redhat.

Email: hhan@redhat.com
Phone: +861065339333

--000000000000c55f7d0598db3478
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Anyone help to review it?<br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2019 at =
1:54 PM Han Han &lt;<a href=3D"mailto:hhan@redhat.com">hhan@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr">ping<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Wed, Nov 13, 2019 at 9:17 PM Han Han &lt;<a href=3D"=
mailto:hhan@redhat.com" target=3D"_blank">hhan@redhat.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">In python3, &#39;f=
ile&#39; is no longer a keyword for file type object. So it<br>
will can error when run the scripts by python3:<br>
<br>
$ python3 ./scripts/vmstate-static-checker.py -s 4.0.json -d 4.1.json<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;./scripts/vmstate-static-checker.py&quot;, line 431, in &=
lt;module&gt;<br>
=C2=A0 =C2=A0 sys.exit(main())<br>
=C2=A0 File &quot;./scripts/vmstate-static-checker.py&quot;, line 378, in m=
ain<br>
=C2=A0 =C2=A0 parser.add_argument(&#39;-s&#39;, &#39;--src&#39;, type=3Dfil=
e, required=3DTrue,<br>
NameError: name &#39;file&#39; is not defined<br>
<br>
Replace file type to argparse.FileType(&#39;r&#39;).<br>
<br>
Signed-off-by: Han Han &lt;<a href=3D"mailto:hhan@redhat.com" target=3D"_bl=
ank">hhan@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/vmstate-static-checker.py | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-che=
cker.py<br>
index d3467288..14f199a0 100755<br>
--- a/scripts/vmstate-static-checker.py<br>
+++ b/scripts/vmstate-static-checker.py<br>
@@ -375,9 +375,9 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0help_text =3D &quot;Parse JSON-formatted vmstate dumps =
from QEMU in files SRC and DEST.=C2=A0 Checks whether migration from SRC to=
 DEST QEMU versions would break based on the VMSTATE information contained =
within the JSON outputs.=C2=A0 The JSON output is created from a QEMU invoc=
ation with the -dump-vmstate parameter and a filename argument to it.=C2=A0=
 Other parameters to QEMU do not matter, except the -M (machine type) param=
eter.&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0parser =3D argparse.ArgumentParser(description=3Dhelp_t=
ext)<br>
-=C2=A0 =C2=A0 parser.add_argument(&#39;-s&#39;, &#39;--src&#39;, type=3Dfi=
le, required=3DTrue,<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;-s&#39;, &#39;--src&#39;, type=3Dar=
gparse.FileType(&#39;r&#39;), required=3DTrue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0help=3D&#39;json dump from src qemu&#39;)<br>
-=C2=A0 =C2=A0 parser.add_argument(&#39;-d&#39;, &#39;--dest&#39;, type=3Df=
ile, required=3DTrue,<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;-d&#39;, &#39;--dest&#39;, type=3Da=
rgparse.FileType(&#39;r&#39;), required=3DTrue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0help=3D&#39;json dump from dest qemu&#39;)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;--reverse&#39;, required=3DFal=
se, default=3DFalse,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0action=3D&#39;store_true&#39;,<br>
-- <br>
2.23.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">Best regards,</div><di=
v dir=3D"ltr">-----------------------------------<br></div><div dir=3D"ltr"=
>Han Han<br>Quality Engineer<br>Redhat.<br><br>Email: <a href=3D"mailto:hha=
n@redhat.com" target=3D"_blank">hhan@redhat.com</a><br>Phone: +861065339333=
<br></div></div></div></div></div></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr=
">Best regards,</div><div dir=3D"ltr">-----------------------------------<b=
r></div><div dir=3D"ltr">Han Han<br>Quality Engineer<br>Redhat.<br><br>Emai=
l: <a href=3D"mailto:hhan@redhat.com" target=3D"_blank">hhan@redhat.com</a>=
<br>Phone: +861065339333<br></div></div></div></div></div></div></div>

--000000000000c55f7d0598db3478--


