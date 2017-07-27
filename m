Received: from eggs.gnu.org ([2001:4830:134:3::10]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daf2b-0003uy-Ap
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daf2W-0006K5-D7
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:25:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1daf2W-0006Jj-71
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1629C112E96
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 09:25:02 +0000 (UTC)
References: <1501075650-6971-1-git-send-email-thuth@redhat.com>
	<20170726140208.GO7620@redhat.com>
	<236fd293-5d5e-0436-afc3-599ae9de6f92@redhat.com>
	<ab87e4f9-c270-80ec-ed3d-8b315dfacef8@redhat.com>
	<b9db0cdc-f03c-dfec-cf6a-bd2b004c5c3e@redhat.com>
	<3824bef1-1d90-e22f-03a1-9b66dbe1ccb5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d96e742-9cd4-6e02-d9ce-54ee369221cf@redhat.com>
Date: Thu, 27 Jul 2017 11:24:59 +0200
MIME-Version: 1.0
In-Reply-To: <3824bef1-1d90-e22f-03a1-9b66dbe1ccb5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a favicon.ico file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org

On 26.07.2017 16:54, Paolo Bonzini wrote:
> On 26/07/2017 16:47, Thomas Huth wrote:
>> If you're willing to maintain that "mess", sure, please go ahead! But
>> please remove my SoB, I don't want to be responsible for all those files ;-)
> 
> Changed it to suggested-by then, and pushed. :>
> 
> Please test!

Does anybody know how a favicon.ico is supposed to work with the
MediaWiki? Looking at the HTML of the Main_Page, it also references such
a file:

<link rel="shortcut icon" href="/favicon.ico" />

But when you try to access that file, you're redirected to the
non-existing wiki page http://wiki.qemu.org/Favicon.ico ...

 Thomas
