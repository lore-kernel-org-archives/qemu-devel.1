Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A29C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B67622CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B67622CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fsf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5W9s-0006vS-5Z
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <iank@fsf.org>) id 1i5W8P-0005UK-JJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:19:46 -0400
Received: from mail.fsf.org ([209.51.188.13]:38665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <iank@fsf.org>) id 1i5W8P-00022I-Dr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:19:45 -0400
Received: from mail.iankelling.org ([72.14.176.105]:44358)
 by mail.fsf.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.69) (envelope-from <iank@fsf.org>)
 id 1i5W8O-0007Nc-OE; Wed, 04 Sep 2019 10:19:44 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
 (envelope-from <iank@fsf.org>)
 id 1i5W8N-0005eg-47; Wed, 04 Sep 2019 10:19:43 -0400
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver> <20190902173432.20f2637b@bahia.lan>
 <2734436.Mu773bgsdE@silver> <87r24xqjoz.fsf@fsf.org>
 <20190904081354.GA19582@redhat.com>
User-agent: mu4e 1.1.0; emacs 27.0.50
From: Ian Kelling <iank@fsf.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190904081354.GA19582@redhat.com>
Date: Wed, 04 Sep 2019 10:19:43 -0400
Message-ID: <87lfv4qh34.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by mail.fsf.org: GNU/Linux 2.2.x-3.x [generic]
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Subject: Re: [Qemu-devel] DMARC/DKIM and qemu-devel list settings
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
Cc: stefanha@gmail.com, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, antonios.motakis@huawei.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> I think we should change mailman settings to *NOT* convert HTML to
> plain text. It is pretty easy to setup mail clients to do this
> conversion when viewing instead, which will avoid the DMARC problems.
>
> eg with mutt you can add
>
>   auto_view text/html
>   alternative_order text/plain text/html
>
> and in $HOME/.mailcap something like
>
>   text/html; elinks -dump -localhost 1 -no-connect 1 -default-mime-type t=
ext/html %s; needsterminal; copiousoutput;
>

Both are reasonable, pick your poison. I use emacs gnus and mu4e, both
convert to plain text by default afaik. Mailman simply calls out to lynx
to do it.

To change this, a list admin will just toggle convert_html_to_plaintext
at https://lists.nongnu.org/mailman/admin/qemu-devel/contentfilter

--=20
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org

