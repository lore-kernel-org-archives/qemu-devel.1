Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C44C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3811B206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlEp+Yyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3811B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsmNC-0004fk-HM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 08:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsmMJ-0003oy-NI
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:05:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsmMH-0004xC-IB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 08:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594123557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gLFuRBvLwoGvjKxJIwA+Kcn0+Go9lcau+AdrV9kDmw=;
 b=MlEp+Yyo4pxTKowcPSxFNOJ5wr1iIhxy+6BoTXsO+R0KrSVm/qBhTK+hl0d62Ht4CPzWZh
 hmytRaULv46bnmTUhMDtzJ+W4CbZ9aDJZAl2Oui//b1+csPfWw9Zs76NYdDKKWZ7Ja3my6
 fcQs1/hNzRNFMwLebpzH5N7ErgpMTro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-slYNxlJKPtWnVSSzPxh5Gg-1; Tue, 07 Jul 2020 08:04:40 -0400
X-MC-Unique: slYNxlJKPtWnVSSzPxh5Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2664107B265;
 Tue,  7 Jul 2020 12:04:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8782B19724;
 Tue,  7 Jul 2020 12:04:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 052351132FD2; Tue,  7 Jul 2020 14:04:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] util/qemu-option: Document the get_opt_value() function
References: <20200629070858.19850-1-philmd@redhat.com>
 <1dec6cd5-42f8-8e9f-cc87-108e46a926cc@linaro.org>
 <87r1tnanuq.fsf@dusky.pond.sub.org>
 <ba9d8dc5-e654-99a7-1481-c5174e366540@redhat.com>
Date: Tue, 07 Jul 2020 14:04:37 +0200
In-Reply-To: <ba9d8dc5-e654-99a7-1481-c5174e366540@redhat.com> (Thomas Huth's
 message of "Tue, 7 Jul 2020 07:48:11 +0200")
Message-ID: <87lfjv7cq2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 07/07/2020 07.35, Markus Armbruster wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>=20
>>> On 6/29/20 12:08 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Coverity noticed commit 950c4e6c94 introduced a dereference before
>>>> null check in get_opt_value (CID1391003):
>>>>
>>>>   In get_opt_value: All paths that lead to this null pointer
>>>>   comparison already dereference the pointer earlier (CWE-476)
>>>>
>>>> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
>>>> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
>>>> for the 'value' parameter".
>>>>
>>>> Since this function is publicly exposed, it risks new users to do
>>>> the same error again. Avoid that documenting the 'value' argument
>>>> must not be NULL.
>>>
>>> I think we should also add some use of __attribute__((nonnull(...))) to=
 enforce
>>> this within the compiler.
>>>
>>> I recently did this without a qemu/compiler.h QEMU_FOO wrapper within
>>> target/arm.  But the nonnull option has optional arguments, so it might=
 be
>>> difficult to wrap in macros.
>>=20
>> Do we support building with a compuler that lacks this attribute?
>
> It seems to be available in GCC 4.0 already:
>
> https://gcc.gnu.org/onlinedocs/gcc-4.0.0/gcc/Function-Attributes.html
>
> ... so the answer to your question is certainly "no". All supported
> compilers should have this attribute.

Why a macro then?


