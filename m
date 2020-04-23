Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1CDC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1872E20776
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctrbRdPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1872E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYX4-0007pF-AE
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRYVu-0007PR-PR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRYVt-0000Ns-L6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:51:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRYVt-0000KI-42
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587635479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cR8LvOvu2dk/FPmQGUJ+Cfx3oAaQuZ4B48zxmxKohNg=;
 b=ctrbRdPzaVDyoOjyAv+IvlnK+nNaQSrahLIYoeS8Qp7zm4JobUqczk5P/bItAITutEV+EG
 3SFJ25luY2TSBOMi9buxplbXWBbVbxoJbwIbSVYQLSMlv5JzEKetlVtxSKPz3okvR0k9el
 S6WVJ7Gue+silfiwxMTsruv5o6Ja0GA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-9dOeUYHeOa6WCNqO4lvCDw-1; Thu, 23 Apr 2020 05:51:18 -0400
X-MC-Unique: 9dOeUYHeOa6WCNqO4lvCDw-1
Received: by mail-wr1-f69.google.com with SMTP id d17so2572584wrr.17
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 02:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SdDH1HFtIV0DJ19T8SqJH9OyFczODidEi2qpnXmfM20=;
 b=m8k4f/yATD18rgw4DC6NqrEed2gJMTT8+aZAP1PozVQPW4EpazuVhmEQSHA6gxhQIj
 n3Zq6+NS8ydnKKQUJfwtqfwz0K77d82kvgfMpPwcitlNZO56JOu4Cy4yLDOijGgTcD3Z
 9kBYMtwgs5XqZBjRs14WAAWfJYSHvUiavSnuSp7DlGiNC0T0BObSt/s8FGwVfJxu+Z9m
 a+odASHflrilQddZDy9ZWvLugnPx0T7sOr3wxqYo3DzaC0jlSuY97P3MDJvwqsBziVvS
 ENwseAhxrh4XL8fJXwTOCPQ2jjNej7mx0ia+keSPDLYjLuKtKcczWDIlPDUQknpaRrgT
 247Q==
X-Gm-Message-State: AGi0Pua20lsIMwNGfWZRtCkpIkLwYW0QbJCKpOdVxvJmArbOOMe5DS1P
 1GZgm9VUGEhy3ecf0DToUuGLb/w24dwcUuac+/OqPylbQR4qzKGc02kv0P6d0HS6h4yqZFk9GSM
 mBJuOCNnhH9PIGQU=
X-Received: by 2002:a1c:8106:: with SMTP id c6mr3230589wmd.88.1587635476857;
 Thu, 23 Apr 2020 02:51:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTkxP/dxHS15yP8C0nIUHGSlxcgNeNfrW6AIFRCTsGoVH5GLMYhhXo3J5DLRMbcPnHIC/T0w==
X-Received: by 2002:a1c:8106:: with SMTP id c6mr3230574wmd.88.1587635476668;
 Thu, 23 Apr 2020 02:51:16 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id 91sm3105665wra.37.2020.04.23.02.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 02:51:15 -0700 (PDT)
Subject: Re: [PATCH 09/11] target/mips: Always enable CONFIG_SEMIHOSTING
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-10-philmd@redhat.com>
 <d07835cf-1021-7399-a28d-09a4a4c225ef@redhat.com>
 <9a138460-9b08-a8bd-ecc9-78f6b227e972@redhat.com>
 <5ebee88a-4ce4-7406-a668-c64e1cc5ae6c@redhat.com>
 <766b5fe0-148e-827c-eb67-ad798a517b1a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b51cecc-a4d6-070c-5342-62c4f24de895@redhat.com>
Date: Thu, 23 Apr 2020 11:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <766b5fe0-148e-827c-eb67-ad798a517b1a@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/04/20 10:43, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> You can add CONFIG_SEMIHOSTING=3Dy directly in the Kconfig file.
>=20
> I didn't know because it is not documented and no examples, but I the
> code is here:
>=20
> =C2=A0=C2=A0=C2=A0 # assignment_var: ID (starting with "CONFIG_")
> =C2=A0=C2=A0=C2=A0 def parse_assignment_var(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.tok =3D=3D TOK_ID:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =
=3D self.val
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not=
 val.startswith("CONFIG_"):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 raise KconfigParserError(self,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'Expected identifier starting with
> "CONFIG_"', TOK_NONE)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.g=
et_token()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 self.data.do_var(val[7:])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise =
KconfigParserError(self, 'Expected identifier')
>=20
> =C2=A0=C2=A0=C2=A0 # assignment: var EQUAL y_or_n
> =C2=A0=C2=A0=C2=A0 def parse_assignment(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var =3D self.parse_assignment_=
var()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.tok !=3D TOK_EQUAL:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise =
KconfigParserError(self, 'Expected "=3D"')
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.get_token()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.data.do_assignment(var, s=
elf.parse_y_or_n())
>=20
> Thanks!

Well yeah, it's a bit of a hack and simply the simplest way to implement
it.  If it turns out that there are other ways to achieve what you need,
it's better.

Paolo


