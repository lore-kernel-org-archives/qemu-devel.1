Received: from eggs.gnu.org ([2001:4830:134:3::10]:60182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dk9Zp-0006NB-K5
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dk9Zm-00084P-R4
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:50:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-13-git-send-email-armbru@redhat.com>
	<20170822145505.643f74fa@nial.brq.redhat.com>
Date: Tue, 22 Aug 2017 15:50:14 +0200
In-Reply-To: <20170822145505.643f74fa@nial.brq.redhat.com> (Igor Mammedov's
	message of "Tue, 22 Aug 2017 14:55:05 +0200")
Message-ID: <87shgjaezt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 12/56] pc-dimm: Make size and address
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com, jsnow@redhat.com

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon,  7 Aug 2017 16:45:16 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Sizes and addresses should use QAPI type 'size' (uint64_t).
>> PCDIMMDeviceInfo members @addr and @size are 'int' (int64_t).
>> qmp_pc_dimm_device_list() implicitly converts from uint64_t.
>> 
>> Change these PCDIMMDeviceInfo members to 'size'.
>> 
>> query-memory-devices now reports sizes and addresses above 2^63-1
>> correctly instead of their (negative) two's complement.
>> 
>> HMP's "info memory-devices" already reported them correctly, because
>> it printed the signed integers with PRIx64 and PRIu32.
> s/signed/unsigned/

Before this patch: signed.  Afterwards: unsigned.  Would

   HMP's "info memory-devices" already reported them correctly, because
   it printed the signed (before the patch) integers with PRIx64 and
   PRIu32.

be clearer?

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Thanks!
