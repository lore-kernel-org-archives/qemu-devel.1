Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cTlBm-0003DT-Tx
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cTlBm-00029a-6U
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:01:51 -0500
Date: Wed, 18 Jan 2017 09:01:26 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20170118080126.nyldkjhxdsxd4u2b@grep.be>
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bob Chen <a175818323@gmail.com>

On Mon, Jan 16, 2017 at 01:36:21PM -0600, Eric Blake wrote:
> Maybe the structured reply proposal can be extended into this (reserve a
> "reply" header that can be issued as many times as desired by the server
> without the client ever having issued the request first, and where the
> reply never uses the end-of-reply marker), but I'm not sure I want to go
> that direction just yet.

It's not necessarily a bad idea, which could also be used for:
- keepalive probes from server to client
- unsolicited ESHUTDOWN messages

both of which are currently not possible and might be useful for the
protocol to have.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
