Received: from eggs.gnu.org ([2001:4830:134:3::10]:59651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eFKek-0004p2-5M
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eFKej-0001t0-7m
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:56:38 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eFKej-0001sp-2g
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:56:37 -0500
Received: by mail-it0-x241.google.com with SMTP id u132so62975ita.0
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 05:56:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5e211649-ccf6-efd9-cabd-a346af7e501d@redhat.com>
References: <1510801633-115970-1-git-send-email-eswierk@skyportsystems.com>
	<5e211649-ccf6-efd9-cabd-a346af7e501d@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 16 Nov 2017 05:55:55 -0800
Message-ID: <CAO_EM_mgO1zSPVkQs1ACYwCw6MfdHidP==5N-tae74_Rte7Auw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] net: Transmit zero UDP checksum as
 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Fleytman <dmitry@daynix.com>, qemu-devel@nongnu.org

On Wed, Nov 15, 2017 at 7:55 PM, Eric Blake <eblake@redhat.com> wrote:
>
> On 11/15/2017 09:07 PM, Ed Swierk via Qemu-devel wrote:
>
> This part below...
>
> >
> > v3:
> >
> > Leave net_tx_pkt_update_ip_checksums() alone since it's only computing
> > a partial sum of the IP pseudo-header.
> >
> > Rename wrapper to net_checksum_finish_nozero() for clarity.
> >
> > v2:
> >
> > Add a wrapper net_checksum_finish_hdr() rather than duplicating the
> > logic at every caller.
>
> ...through here, belongs...
>
> >
> > Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
> > ---
>
> ...here, after the --- separator (you can have more than one ---; 'git
> am' stops parsing at the first).  It is data that is useful to
> reviewers, but will be meaningless a year from now when browsing git
> history (at which point we won't care how many revisions the patch went
> through on the list, but only what was checked in).

Thanks for the clue. I'll repost a corrected version.

Maybe checkpatch.pl should squawk if it sees ^v[0-9]\+: before the first ---?

--Ed
