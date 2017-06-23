Received: from eggs.gnu.org ([2001:4830:134:3::10]:47379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dOIKo-0001WU-EV
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dOIKk-0007iO-5i
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dOIKj-0007hj-VR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 02:44:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170613140546.28227-1-vadim.galitsyn@profitbricks.com>
	<20170614092040.GB2687@work-vm>
	<CAPHE7NqmDh-BKNg1-r8FNXw=qFSs9vdHPBO9gYc61js7fTkOpg@mail.gmail.com>
	<20170614154043.GE2687@work-vm> <874lva21jb.fsf@dusky.pond.sub.org>
	<CAPHE7NppPyGfe=29twDOUdWT=CXcJ8M935AbmtvPNS3-KorYzA@mail.gmail.com>
Date: Fri, 23 Jun 2017 08:44:39 +0200
In-Reply-To: <CAPHE7NppPyGfe=29twDOUdWT=CXcJ8M935AbmtvPNS3-KorYzA@mail.gmail.com>
	(Vadim Galitsyn's message of "Thu, 22 Jun 2017 17:02:03 +0200")
Message-ID: <87zicz5hk8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: imammedo@redhat.com, Mohammed Gamal <mgamal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:

> Hi Markus,
>
> Thank you for the input.
>
>> However, your query-memory looks like it could fail.
>
> With the latest version of a patch (
> http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03475.html)
> "query-memory" can fail only in two cases:
>
> a) if in QOM there is an object of type of TYPE_PC_DIMM which has no
> property of type PC_DIMM_SIZE_PROP, or
> b) PC_DIMM_SIZE_PROP is not represented as an integer.
>
> As far as I understand both (a) and (b) can happen only in case if QOM
> somehow corrupted which is not a normal case
> (please correct me if I am wrong).

These feel like programming errors.  They are impossible to test without
screwing up the program.  Untestable error recovery is commonly wrong.
I recommend to assert instead.  Igor, what do you think?

> Please also note, this is not the last version of the patch since new
> functionality was suggested
> to be included (NUMA information).
>
> If patch will be accepted, I think we would need a test case for it since
> command output differs once memory
> was hot-added/removed per given NUMA node. When final functionality will be
> negotiated, I will come up
> with test scenario and test case itself.

Thanks!
