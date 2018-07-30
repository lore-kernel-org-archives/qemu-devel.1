Received: from eggs.gnu.org ([2001:4830:134:3::10]:48335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkA3A-00071I-MG
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkA37-0000SB-3Y
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:25:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fkA36-0000Ru-Gr
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:25:28 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-14-armbru@redhat.com>
	<1c126eed-8b47-b61a-69d8-38176e1e586d@redhat.com>
	<87wotdxgt2.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d7397fd-87e3-32a3-e5e2-38557ae65e2e@redhat.com>
Date: Mon, 30 Jul 2018 10:25:26 -0500
MIME-Version: 1.0
In-Reply-To: <87wotdxgt2.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/23] tests: Clean up string
 interpolation around qtest_qmp_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, f4bug@amsat.org

On 07/30/2018 03:34 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> [...]
>> (We really want to assert that any % interpolations in our JSON parser
>> are NOT embedded in '').
> 
> I'll look into that, but it'll be in a separate series.

Agreed.  In fact, my more ambitious series had reached that point by 
implementing %% interpolation inside strings, combined with asserting 
that %% cannot occur except within strings during the JSON parse, then 
during the JSON interpolation that the only use of % within strings was 
the %% escape (so that we no longer risk consuming a va-arg during 
string interpolation, while still benefiting from gcc's -Wformat 
checking).  So probably one of the easier things to revive, once this 
series lands.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
