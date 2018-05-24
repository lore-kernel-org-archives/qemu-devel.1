Received: from eggs.gnu.org ([2001:4830:134:3::10]:40728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLdia-0000Gs-Nv
	for qemu-devel@nongnu.org; Wed, 23 May 2018 20:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLdiZ-0005ZL-Up
	for qemu-devel@nongnu.org; Wed, 23 May 2018 20:02:56 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-36-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6b0e43c5-f35b-5865-e423-ff6de432bb86@redhat.com>
Date: Wed, 23 May 2018 20:02:50 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-36-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 35/40] job: Add JOB_STATUS_CHANGE QMP
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/18/2018 09:21 AM, Kevin Wolf wrote:
> This adds a QMP event that is emitted whenever a job transitions from
> one status to another.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

That's a lot of events, and a lot are redundant to what we already
transmitted under block jobs; it also has the effect of making internal
state changes explicit behavior that we're responsible for maintaining
for external clients.

Is that what we want here?

(I mean, the answer is probably "Yes" because you're here writing the
patch, but I was hoping to find your motivation.)
