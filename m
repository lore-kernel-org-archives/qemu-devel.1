Received: from eggs.gnu.org ([2001:4830:134:3::10]:42331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3OWD-0003YF-MS
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d3OW7-0001ja-P0
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:06:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d3OW7-0001if-Fm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:06:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QF43fV112424
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:06:06 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebygvf1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:06:05 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 26 Apr 2017 16:06:03 +0100
Date: Wed, 26 Apr 2017 17:05:53 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <f2769605-4cd0-7f95-0409-850258ccbaeb@redhat.com>
References: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
	<f2769605-4cd0-7f95-0409-850258ccbaeb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170426170553.1d45e1d7.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/char: remove console_exit function
 in sclp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Zihan Yang <tgnyang@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 26 Apr 2017 09:42:02 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 04/26/2017 07:53 AM, Zihan Yang wrote:
> > Currently, the console_exit function in sclpconsole-lm.c and sclpconsole.c
> > does nothing, so remove them and convert the callback in SCLPEventClass to
> > void. Since there is a NULL check on the DeviceClass exit callback as
> > suggested by Frederic Konrad, it should be safe to remove them.
> 
> When sending a patch series, please be sure to include a 0/5 cover
> letter, to make it easier on automated tooling that processes the list.
> You can use 'git config format.coverletter auto' to make it easier to
> remember this for patches created by 'git format-patch'/'git send-email'.
> 
> More submission hints at: http://wiki.qemu.org/Contribute/SubmitAPatch
> 

Nod.

Of the hints in the wiki page above, I'd especially like to point out
versioning and change logs.
