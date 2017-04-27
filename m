Received: from eggs.gnu.org ([2001:4830:134:3::10]:59648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3ee5-0003QR-RZ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3ee1-0004r2-TP
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:19:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3ee1-0004qu-Mr
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 04:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BF3C46D09E
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 08:19:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170313162909.GI4799@redhat.com> (Daniel P. Berrange's message
	of "Mon, 13 Mar 2017 16:29:09 +0000")
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-2-quintela@redhat.com>
	<20170313162909.GI4799@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 27 Apr 2017 10:19:17 +0200
Message-ID: <87k266jm9m.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/16] qio: create new qio_channel_write_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Mon, Mar 13, 2017 at 01:44:19PM +0100, Juan Quintela wrote:
>> The function waits until it is able to write the full iov.
>> 
>
> Can you make sure this is covered in the test suite. Something added
> or changed in tests/io-channel-helpers.c should be sufficient. eg use
> it from test_io_thread_writer() when applicable

Ok, I integreted together the two patches, and added tests for:

qio_channel_writev - qio_channel_readv
qio_channel_writev_all - qio_channel_readv
qio_channel_writev - qio_channel_readv_all
qio_channel_writev_all - qio_channel_readv_all

I did it only for test-io-channel-buffer.c, though.

Thanks, Juan.
