Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B5C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC3920833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4g58pAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC3920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iblqA-0002AV-LE
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibloj-0001S9-DA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibloh-0004rw-6F
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:32:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibloh-0004rX-2m
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575293562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=LCEUvF/RvV6XhHIr058el7M8Ir95slvfVbm42Y0+YFI=;
 b=T4g58pAIny1pkSVNG/5HJWxO16ZCGyfVSJceYGhRha0QjQe+suQZAJ+hIfwbHSp8IvVi81
 3/p0CifcGO4WXrSHBTbFjZjKdmzi8ZL2S1pFGY1Ev7mPOlm8i6FszqA7/C2FiTPtf0AF6k
 lylgipIhCensUCqM0ZTC1zG6xDl0UlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-A-26uqQqM6WeqKMqrirrzg-1; Mon, 02 Dec 2019 08:32:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8EF4800D41;
 Mon,  2 Dec 2019 13:32:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 444B55C3FA;
 Mon,  2 Dec 2019 13:32:32 +0000 (UTC)
Subject: Re: virtiofsd: Where should it live?
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com> <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
Date: Mon, 2 Dec 2019 14:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87k17ekhs9.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: A-26uqQqM6WeqKMqrirrzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: mszeredi@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/12/2019 13.56, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On Tue, 26 Nov 2019 at 12:15, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>>>
>>> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>>>> My main objection to 'contrib/' is actually the perceived notions
>>>> about what the contrib directory is for. When I see 'contrib/'
>>>> code in either QEMU, or other open source projects, my general
>>>> impression is that this is largely unsupported code which is just
>>>> there as it might be interesting to someone, and doesn't typically
>>>> get much ongoing dev attention.
>>
>>>> virtiofsd is definitely different as it is intended to be a
>>>> fully production quality supported tool with active dev into
>>>> the future IIUC.
>>>>
>>>> IOW, if we did decide we want it in QEMU, then instead of
>>>> '$GIT/contrib/virtiofsd', I'd prefer to see '$GIT/virtiofsd'.
>>>
>>> I'm not sure it deserves a new top level for such a specific tool.
>>
>> Maybe, but I think I agree with Daniel that 'contrib/' is
>> probably not the right place for it if it's something that
>> we care about supporting. 'contrib' to me is "bucket of stuff
>> that we didn't really feel strongly we wanted to reject but
>> which is probably random special-cases or other obscure
>> stuff, don't bother looking in here and don't assume it's
>> going to work either".
>=20
> Agree.
>=20
> We have source for several separate programs in the root directory
> already: qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> qemu-keymap, qemu-seccomp, qemu-ga.  Just a .c file when that suffixes,
> else a subdirectory, except for qemu-io, which is two .c files in the
> root, plus include/qemu-io.h.  Putting virtiofsd/ there follows
> qemu-ga's precedence.

IMHO the root directory is still way too overcrowded. Maybe we should
simply introduce a "tools" subdirectory?

 Thomas


