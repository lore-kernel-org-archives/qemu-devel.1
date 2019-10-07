Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77A3C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8E720679
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8E720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHO2q-0002y8-Oi
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 04:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHO1x-0002S3-Rf
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHO1w-0007d2-Pq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHO1u-0007c8-Lj; Mon, 07 Oct 2019 04:06:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E24EA10C0929;
 Mon,  7 Oct 2019 08:06:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADDFC5C219;
 Mon,  7 Oct 2019 08:06:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 31E3A1138648; Mon,  7 Oct 2019 10:05:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/11] RFC crypto/luks: encryption key
 managment using amend interface
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <632e3a8b-ee54-50e0-83a2-ea82ad8e061f@redhat.com>
 <d371336cfe6b8428ebc9a68a9787c19082e9f0de.camel@redhat.com>
Date: Mon, 07 Oct 2019 10:05:55 +0200
In-Reply-To: <d371336cfe6b8428ebc9a68a9787c19082e9f0de.camel@redhat.com>
 (Maxim Levitsky's message of "Sun, 22 Sep 2019 11:17:03 +0300")
Message-ID: <871rvpj7z0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 07 Oct 2019 08:06:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Fri, 2019-09-20 at 17:14 -0400, John Snow wrote:
>> 
>> On 9/12/19 6:30 PM, Maxim Levitsky wrote:
>> > This patch series is continuation of my work to add encryption
>> > key managment to luks/qcow2 with luks.
>> > 
>> > This is second version of this patch set.
>> > The changes are mostly addressing the review feedback,
>> > plus I tested (and fixed sadly) the somewhat ugly code
>> > that allows to still write share a raw luks device,
>> > while preveting the key managment from happening in this case,
>> > as it is unsafe.
>> > I added a new iotest dedicated to that as well.
>> > 
>> > Best regards,
>> > 	Maxim Levitsky
>> > 
>> 
>> What branch is this based on?
>> It doesn't seem to apply to origin/master.
>> 
>> --js
> It is based on refactoring patch series I send before,
> which is also under review:
> "[PATCH v2 00/13] RFC crypto/luks: preparation for encryption key managment"

Recommend to note such dependencies in the cover letter as

Based-on: <message-id>

