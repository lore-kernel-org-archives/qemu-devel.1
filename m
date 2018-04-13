Received: from eggs.gnu.org ([2001:4830:134:3::10]:36955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f70ya-0008FB-Ot
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f70yW-0008Gi-Ni
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:51:00 -0400
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
	<df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f3d7c3d0-26fe-37db-abb3-0e99373ae315@redhat.com>
Date: Fri, 13 Apr 2018 17:50:38 +0200
MIME-Version: 1.0
In-Reply-To: <df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 13.04.2018 17:28, Halil Pasic wrote:
>=20
>=20
> On 04/13/2018 04:30 PM, Thomas Huth wrote:
>> "size_t" should be an unsigned type - the signed counterpart is called
>> "ssize_t" in the C standard instead. Thus we should also use this
>=20
> The first sentence sounds like ssize_t is too a type defined by some
> C standard. Is it or does ssize_t come form somewhere else?

Arrr, seems like ssize_t is rather coming from POSIX than from the C
standard, thanks for the hint. I'll rephrase the first sentence to:

"size_t" should be an unsigned type according to the C standard, and
most libc implementations provide a signed counterpart called "ssize_t".

OK?

>> convention in the s390-ccw firmware to avoid confusion. I checked the
>> sources, and apart from one spot in libc.c (which now uses ssize_t wit=
h
>> this patch), the code should all be fine with this change.
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>=20
> This is certainly an improvement over the confusing signed size_t, so:
>=20
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Thanks!

> BTW The stuff behind the buglink is a bit misleading. The description
> states the problem as can't escape loop (IMHO) and the  bug
> status say 'confirmed'.
>=20
> What actually happened is that it turned out the problem initially repo=
rted,
> was not existent. Yet the bug report helped us find another problem:
> confusing names.

Ok, I've updated the bug title.

> To complicate understanding even further, the comments on the bug
> only contain this realization hidden behind a link.

Oh well, yes, the bridge between the bugtracker and the mailing list
really su...ffers from many problems. Normally replies should show up in
the bug tracker as well, but in this case the bridge just failed.

 Thomas
