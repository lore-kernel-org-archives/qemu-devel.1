Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1C821D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxB78LQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1C821D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0bG-0006tc-JI
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iX0aG-0006QL-3J
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iX0aE-0000JA-AN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:18:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38656
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iX0aC-0000Im-BC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574158682;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JGN8bGskQM8YpgZ33w4EN+sral+6l6V3FhQpUqjnaw=;
 b=XxB78LQ0VDTuFHSXeYx+BYucY1Ay1B6iEWXstUG6rBcuvy+5Rbcty+OwZfUu65l+Ju03WD
 gJNqvukbLEBX61IhewjkzEZX+otHMt7Q7+xy32laly83B8Fj4MX2Dgg8XCDyAx0fqqeVzm
 cKRH0ImAIZZGtfUXmi/JtKFiGsYTGqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-mMSDT5iKO1ecfW7I0UHJjg-1; Tue, 19 Nov 2019 05:18:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 376E11005516;
 Tue, 19 Nov 2019 10:17:59 +0000 (UTC)
Received: from redhat.com (ovpn-116-161.ams2.redhat.com [10.36.116.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C53094D703;
 Tue, 19 Nov 2019 10:17:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: Call for agenda for 2019-11-19 KVM call
In-Reply-To: <87d0dvaghw.fsf@trasno.org> (Juan Quintela's message of "Wed, 13
 Nov 2019 17:27:39 +0100")
References: <87d0dvaghw.fsf@trasno.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 19 Nov 2019 11:17:54 +0100
Message-ID: <87r224gofh.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mMSDT5iKO1ecfW7I0UHJjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: kvm-devel <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> wrote:
> Hi

Hi folks

as there are no agenda, call gets cancelled.

Happy hacking and see you in two weeks.

Later, Juan.


>
> Please, send any topic that you are interested in covering.
>
> At the end of Monday I will send an email with the agenda or the
> cancellation of the call, so hurry up.
>
> After discussions on the QEMU Summit, we are going to have always open a
> KVM call where you can add topics.
>
>  Call details:
>
> By popular demand, a google calendar public entry with it
>
>   https://www.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZwNzRoMHE=
4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
>
> (Let me know if you have any problems with the calendar entry.  I just
> gave up about getting right at the same time CEST, CET, EDT and DST).
>
> If you need phone number details,  contact me privately
>
> Thanks, Juan.    =20


