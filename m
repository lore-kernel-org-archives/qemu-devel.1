Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxzxR-0002ob-5C
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 15:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxzxO-00020a-17
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 15:28:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fxzxN-0001zb-Rl
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 15:28:45 -0400
Date: Thu, 6 Sep 2018 20:28:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180906192841.GG2639@work-vm>
References: <1532115624-27568-1-git-send-email-walling@linux.ibm.com>
	<20180808190023.GN2734@work-vm>
	<c7781746-5bc5-be44-9596-b4504ea1d5a2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7781746-5bc5-be44-9596-b4504ea1d5a2@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] monitor: print message when using
 'help' with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: stzi@linux.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com

* Collin Walling (walling@linux.ibm.com) wrote:
> On 08/08/2018 03:00 PM, Dr. David Alan Gilbert wrote:
> > * Collin Walling (walling@linux.ibm.com) wrote:
> >> When typing 'help' followed by an unknown command, QEMU will
> >> not print anything to the command line to let the user know
> >> they typed a bad command. Let's fix this by printing a message
> >> to the monitor when this happens. For example:
> >>
> >>     (qemu) help xyz
> >>     unknown command: 'xyz'
> >>
> >> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
> >> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> 
> Thank you for the R-b. 
> 
> And pardon my impatience, but any chance this patch might get picked up, or
> does it require some more review first?

It will on my next HMP pull; it's just not many pulls are happening
at the moment; it should be in by the end of the month.

Dave

> [...]
> 
> 
> -- 
> Respectfully,
> - Collin Walling
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
