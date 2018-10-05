Received: from eggs.gnu.org ([2001:4830:134:3::10]:50493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8TQI-0007hT-N2
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8TGI-0007lB-OZ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:47:35 -0400
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-14-vsementsov@virtuozzo.com>
	<20181004124421.GC6009@localhost.localdomain>
	<d691c927-e37a-1178-8180-9893278aa02c@virtuozzo.com>
	<20181004145241.GG6009@localhost.localdomain>
	<19e42ee8-fdbe-e637-6728-bfc10b137f63@virtuozzo.com>
	<46e224bd-8c1f-4565-944e-52440e85e2f0@virtuozzo.com>
	<20181005155213.GB4606@localhost.localdomain>
	<05adf79a-4ae1-0ba1-aa7f-7696aa043594@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac7c795b-127f-8f2e-4953-95b74f57ffee@redhat.com>
Date: Fri, 5 Oct 2018 11:47:17 -0500
MIME-Version: 1.0
In-Reply-To: <05adf79a-4ae1-0ba1-aa7f-7696aa043594@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/18] block: introduce new filter
 driver: fleecing-hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

On 10/5/18 11:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> 05.10.2018 18:52, Kevin Wolf wrote:
>> Hi Vladimir,
>>
>> can you please check your mailer settings? The plain text version of the
>> emails is hardly legible because it mixes quotes text and replies. I
>> had to manually open the HTML part to figure out what you really wrote.
> 
> I've sent it from other thunderbird instance from home, I hope
> thunderbird at work (where I'm composing now) is ok..

Comparing the two:

Home:
Message-ID: <46e224bd-8c1f-4565-944e-52440e85e2f0@virtuozzo.com>
...
Content-Type: multipart/alternative;
	boundary="_000_46e224bd8c1f4565944e52440e85e2f0virtuozzocom_"

Work:
Message-ID: <05adf79a-4ae1-0ba1-aa7f-7696aa043594@virtuozzo.com>
...
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF06DD561001084699A8EB982D66721B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64

So, the difference is that at home, you haven't told thunderbird to send 
plain-text only emails to specific recipients (setting up the list as 
one of those recipients that wants plain-text only), and something else 
in your local configurations then results in a multipart email where the 
html portion looks fine but the plain-text portion has horrendous 
quoting. But at work, you are configured for plain-text-only output, 
html is not even available, and the quoting is decent from the start.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
