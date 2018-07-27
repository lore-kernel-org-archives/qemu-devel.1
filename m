Received: from eggs.gnu.org ([2001:4830:134:3::10]:37028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj69K-0000dA-Py
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj69G-00027Y-T2
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:03:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj69G-00027S-Nj
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:03:26 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
	<55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9244e265-82fe-42b4-330c-9005bde0a983@redhat.com>
Date: Fri, 27 Jul 2018 12:03:25 -0500
MIME-Version: 1.0
In-Reply-To: <55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/23] libqtest: Remove
 qtest_qmp_discard_response() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org

On 07/27/2018 11:46 AM, Thomas Huth wrote:
> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>> qtest_qmp_discard_response(...) is shorthand for
>> qobject_unref(qtest_qmp(...), except it's not actually shorter.
> 
> But the latter is IMHO harder to read.

Maybe, but then it lends itself well to:

QObject *rsp = qtest_qmp(...);
qobject_unref(rsp);

which is where you do insert tests for valid responses.

> And it might be shorter in the compiled binary (one function call vs. two).

The size of the test binaries is not our biggest concern.

> 
>> Moreover, the presence of these functions encourage sloppy testing.
> 
> Shouldn't we then rather fix the tests to check for valid responses
> instead of replacing this function with harder-to-read code?

I think such fixes are now easier to make, but can be separate followup 
patches. The mechanical conversion is fine to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
