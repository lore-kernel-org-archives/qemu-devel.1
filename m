Received: from eggs.gnu.org ([209.51.188.92]:57114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbgq-00019q-EZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbdA-0007Rd-Aq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:53:45 -0400
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-2-jsnow@redhat.com>
	<5746f6e2-c6bc-23a4-686f-b6943fedbe2c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f8d5c4bd-13c3-8230-52d8-b877a10c9577@redhat.com>
Date: Tue, 30 Apr 2019 18:53:40 -0400
MIME-Version: 1.0
In-Reply-To: <5746f6e2-c6bc-23a4-686f-b6943fedbe2c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] Makefile: add nit-picky mode to
 sphinx-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kchamart@redhat.com" <kchamart@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "aliang@redhat.com" <aliang@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, Fam Zheng <fam@euphon.net>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>



On 4/29/19 5:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> 27.04.2019 1:15, John Snow wrote:
>> If we add references that don't resolve (or accidentally remove them),
>> it will be helpful to have an error message alerting us to that.
> 
> the wording still a bit in conflict with the fact that -n is originally a warning, not error,
> but I don't really care:
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

Ah, sorry, I missed that. Not nice to ignore review comments. How about
this:

"If we add references that don't resolve (or accidentally remove them),
it will be helpful to have warning messages alerting us to that.

Further, turn warnings into errors so we can be alerted to these
problems sooner rather than later."

I can fix it in staging. Thank you for your review again.

--js
