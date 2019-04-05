Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F5C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450A621738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="b+ucskhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450A621738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRpv-0006sv-Kg
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:37:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hCRpB-0006YB-MU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hCRp9-0006Yr-Pb
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:36:17 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1hCRoh-0005X4-Fs
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
	; s=25047;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Fu+yNULqTuZn52ajiL+ybuNF/j0yduf0EwxUfxcOuE8=;
	b=b+ucskhEsTA8VIXX3Kdx2MCMs0
	Cr8KCdYdL+Zvv2ZqsTDqcnTZClHXY4B5HlDvUurU9Q/pJ0foCyIupqXUTvW6tM/St47bcp43d0B7+
	HGpNJIUFhXxl5lq4BgGd8Y6sEqXJXZZuEXhiQHdlMeDUNH8fKVQezIloaU53VKHxnkV0=; 
Received: from rob92-5-82-227-227-196.fbx.proxad.net ([82.227.227.196]
	helo=[192.168.0.35]) by iserv.reactos.org with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <hpoussin@reactos.org>)
	id 1hCRoc-0005JR-Ab; Fri, 05 Apr 2019 16:35:42 +0000
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <ef6ca1d8-50ac-5239-34eb-be05fad7af69@reactos.org>
Date: Fri, 5 Apr 2019 18:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
Subject: Re: [Qemu-devel] How to correctly use more than 2 floppy drives?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405163541.XtaqK44hqPzGEvZICc4iNx1NIXTeh4fLn6RNZunGd9U@z>

Le 05/04/2019 à 12:29, Philippe Mathieu-Daudé a écrit :
> Hi,
> 
> I am trying to understand the possible values for the MAX_FD variable
> used by the floppy controller model (hw/block/fdc.c).
> 
> Looking at git history:
> 
> - 2004-01-05 7138fcfbf7dd + 8977f3c107ef (Jocelyn Mayer):
>    FDC introduced with "#define MAX_FD 2"
> 
> - 2008-04-29 78ae820cfeb0 (Hervé Poussineau):
>    Supports up to 4 floppy drives if MAX_FD is set to 4
>    Migration stream knows about runtime value of MAX_FD
> 
> - 2009-09-10 d7a6c2703577 (Juan Quintela):
>    FDC vmstate-ified
>    Migration stream use compile time value of MAX_FD
> 
> Since 7138fcfbf7dd MAX_FD has always been defined as 2.
> 
> Since d7a6c2703577 MAX_FD can not be different than 2 without breaking
> migration.
> 
> If I understand correctly migration, first we should change in
> vmstate_fdc the user-definable MAX_FD by a constant 2 value.
> 
> Then to be able to use >2 floppy disks I have to modify the the
> vmstate.version_id, and
> 
> 1/ add a new field in the vmstate_fdc containing the number of drives
> and add code to check >2 and adapt
> 
> or
> 
> 2/ change MAX_FD to 4 for all the codebase, adding some code to migrate
> to older FDC with only 2 disks...
> 
> Another option I don't like is:
> 
> 3/ get ride of MAX_FD != 2 and clean the codebase...
> 
> $ git grep '#if MAX_FD'
> hw/block/fdc.c:744:#if MAX_FD == 4
> hw/block/fdc.c:758:#if MAX_FD == 4
> hw/block/fdc.c:1317:#if MAX_FD == 4
> hw/block/fdc.c:1340:#if MAX_FD == 4
> hw/block/fdc.c:2041:#if MAX_FD == 4
> hw/block/fdc.c:2079:#if MAX_FD == 4
> hw/block/fdc.c:2104:#if MAX_FD == 4
> 
> Hervé, what board are/were you using with 4 floppy drives?

That was only an attempt to support 4 drives in code, as controller was able to do it.
However, no emulated board took advantage of it, so that's why it kind-of regressed.

Feel free to choose the solution you prefer.

Hervé

> BTW this link is somehow interesting :)
> https://www.seasip.info/VintagePC/floppies.html
> 
> Thanks,
> 
> Phil.
> 


