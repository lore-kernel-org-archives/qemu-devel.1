Received: from eggs.gnu.org ([2001:4830:134:3::10]:39607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUWf8-0003G0-3F
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUWf4-00068F-Vs
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:47:50 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-11-vsementsov@virtuozzo.com>
	<20171228061457.GI9192@lemon>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b601579d-26ab-e891-4921-42345bab7b38@virtuozzo.com>
Date: Thu, 28 Dec 2017 14:47:36 +0300
MIME-Version: 1.0
In-Reply-To: <20171228061457.GI9192@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v9 10/13] migration: add postcopy migration
 of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, jsnow@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

28.12.2017 09:14, Fam Zheng wrote:
> On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps,
>> associated with root nodes and non-root named nodes are migrated.
>>
>> If destination qemu is already containing a dirty bitmap with the same name
>> as a migrated bitmap (for the same node), then, if their granularities are
>> the same the migration will be done, otherwise the error will be generated.
>>
>> If destination qemu doesn't contain such bitmap it will be created.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Looks good in general, a few nits below.

Agree with all, will fix


-- 
Best regards,
Vladimir
