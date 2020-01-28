Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0A6C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C4A2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g670kYX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C4A2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMyW-0008JI-5u
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1iwMxc-0007YZ-Ci
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1iwMxb-0005Pe-8k
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:15:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1iwMxb-0005Ni-3F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580202902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XT2Qv4jIhjiYUNlS4/EGLaytzd7mhUBKBIfOyMND0zs=;
 b=g670kYX/2XAX+auVr4mysYDh2gneqpPW81emieoo7ElJG6DhjABV4B+XzZDYjVkfIJnjaf
 loIQHVnVnIQZIw3hz0vPHeh3Mmkoa2vBFaDEe3uYNRs4Fp0oC83j0Kk9kn4RZj4bgdiORX
 CjWya54wTwJuzeniKMeKUxTTwSsgWzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-bNJrWSxgOCChd12ZD_bM9g-1; Tue, 28 Jan 2020 04:13:42 -0500
X-MC-Unique: bNJrWSxgOCChd12ZD_bM9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E59510120A1;
 Tue, 28 Jan 2020 09:13:41 +0000 (UTC)
Received: from lpt (unknown [10.43.2.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0706E5C219;
 Tue, 28 Jan 2020 09:13:34 +0000 (UTC)
Date: Tue, 28 Jan 2020 10:13:32 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 00/13] RFC: [for 5.0]: HMP monitor handlers cleanups
Message-ID: <20200128091332.GA15300@lpt>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <2e885a1d-94c7-53b5-44f7-feffe70f57c3@redhat.com>
 <20200127204355.GE4544@andariel.pipo.sk>
 <12217cd6-7866-ce9c-c0da-24775f9d045d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <12217cd6-7866-ce9c-c0da-24775f9d045d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 27, 2020 at 04:01:31PM -0500, John Snow wrote:
>
>
>On 1/27/20 3:43 PM, Peter Krempa wrote:
>> On Mon, Jan 27, 2020 at 14:39:02 -0500, John Snow wrote:
>>>
>>>
>>> On 1/27/20 5:36 AM, Maxim Levitsky wrote:
>>>> This patch series is bunch of cleanups
>>>> to the hmp monitor code.
>>>>
>>>> This series only touched blockdev related hmp handlers.
>>>>
>>>> No functional changes expected other that
>>>> light error message changes by the last patch.
>>>>
>>>> This was inspired by this bugzilla:
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1719169
>>>>
>>>> Basically some users still parse hmp error messages,
>>>> and they would like to have them prefixed with 'Error:'
>>>>
>>>

[...]

>> The bug was reported at the time when libvirt didn't use blockdev yet,
>> but at this point it's pointless from our side.

Just for the record, this bug was the motivation for the prefix request:
https://bugzilla.redhat.com/show_bug.cgi?id=1718255

>> This wouldn't even fix
>> the scenario when old (pre-5.10) libvirt would use new qemu because the
>> drive-add handler never checked the error prefix.

And running older libvirt with newer QEMU is not something we care
about.

Jano

>>
>> [1] https://libvirt.org/git/?p=libvirt.git;a=blob;f=src/qemu/qemu_monitor_text.c;h=9135a11f0a3aae718c86bb199112fba8d16d4d80;hb=HEAD
>>
>
>Thank you for the report from libvirtville :)
>
>--js
>
>

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl4v+zAACgkQ+YPwO/Ma
t53DdAgAgJ18BK5mReVwf5nlsoqlI9wqbU/klMGCeLgtyghU2neDhlKHFFVMNB94
RiCf51dQz23sqH1FDQURUI4gpCE3699bb5mwxUJi0j3GlnybwaPJa/p5YY6SaN9l
NtBXvEVkUjPqZ0W53qbJrQgIO0/6C7ARZtJJSXS7HBfBFzH5DGcwDM1cudkmcgrP
n0zgbwG816B6MCbma8rLPvMwXicj8j5YJewGttjDGeYe9bTgcj4elleR55IPsTCD
6PXch0FuHeO62+QyVy68MALiwtgqVGcAMOdFp1hQ9IuLU1du/GKTJ271WJTRM/jt
ZcyJcd7OMHmw2//YyO2lsfjATW37Wg==
=SWW7
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--


