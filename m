Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85902C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A015206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A015206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK0MT-0001wq-3K
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:53:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hK0Lh-0001eg-AM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hK0Lf-0002MZ-34
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:53:04 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:42038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1hK0Le-0002H3-Cg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:53:03 -0400
Received: from localhost.localdomain (prva10-snat226-2.provo.novell.com
	[137.65.226.36])
	by smtp2.provo.novell.com with ESMTP (TLS encrypted);
	Fri, 26 Apr 2019 06:52:49 -0600
To: Gerd Hoffmann <kraxel@redhat.com>
References: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
	<20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
	<ef5b2ec7-f796-becd-f488-bb17538e93bb@suse.com>
	<20190426114857.jrso2nox5tdgtp5k@sirius.home.kraxel.org>
From: Lin Ma <lma@suse.com>
Message-ID: <2fea760f-db60-0edc-889c-7a73c3f15375@suse.com>
Date: Fri, 26 Apr 2019 20:52:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190426114857.jrso2nox5tdgtp5k@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.250.81
Subject: Re: [Qemu-devel] About pt-br keyboard layout
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426125245.0q80odwTDF4GThI2VxMUHQbzBXc9hDMJD1hM5sijzAc@z>


On 4/26/19 7:48 PM, Gerd Hoffmann wrote:
>>> So -k must match the *hosts* keyboard layout.
>> So, that means, If I launch qemu with -k pt-br on a host, I need to ensure
>> the keyboard layout
>> must be pt-br as well onthathypervisorhost,Then when I connected to this vnc
>> server(qemu)
>> throughvncviewer on mylaptop(us keyboard layout), I type shift + 6, I can
>> get¨(diaeresis)
>> character, am I right?
> No.  I've simplified a bit, assuming both vncviewer and qemu run on the
> host machine.  -k $layout must match the keyboard layout of the machine
> running vncviewer.  So, in your case it should be us (the laptops
> layout).
:-)  Thank you very much!
Lin

