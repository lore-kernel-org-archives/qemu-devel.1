Received: from eggs.gnu.org ([2001:4830:134:3::10]:39645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLdcM-0007G7-MN
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLdcL-0003ER-US
	for qemu-devel@nongnu.org; Wed, 23 May 2018 19:56:30 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-37-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4f00421d-cd24-2d61-d1d5-08bd97a476b2@redhat.com>
Date: Wed, 23 May 2018 19:56:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-37-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/40] job: Add lifecycle QMP commands
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
> +{ 'command': 'job-complete', 'data': { 'id': 'str' } }

Do we have to name it this? I've always disliked how "complete" is used
as both a verb and an adjective in our code (hence why I used such
bizarre phrasings like "concluded" in my jobs patches) ...

I don't necessarily have a better suggestion, but now's the chance to
ask the question.

I guess you don't have a better suggestion either, otherwise you'd have
changed it.

--js
