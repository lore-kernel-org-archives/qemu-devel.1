Received: from eggs.gnu.org ([2001:4830:134:3::10]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMEzY-0002WX-3G
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMEyX-0002Sr-9d
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:18:40 -0500
Date: Tue, 5 Dec 2017 16:17:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171205161726.2cda9301.cohuck@redhat.com>
In-Reply-To: <20171204140150.20483-9-david@redhat.com>
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 8/9] s390x/tcg: we already
 implement the Set-Program-Parameter facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon,  4 Dec 2017 15:01:49 +0100
David Hildenbrand <david@redhat.com> wrote:

> The Set-Program-Parameter facility (also known as Load-Program-Parameter
> faciliy) provides the LPP instruction used to load the program

s/faciliy/facility/

> parameter. We already implement that instruction in TCG, so add it to our
> list.
> 
> Note: Not documented in the PoP but in "The Load-Program-Parameter and
> CPU-Measurement Facilities) - SA23-2260-05 document.

Yeah for additional docs! Not. (At least it's public.)

> 
> While at it, make the whole list ordered (accoring to cpu_features_def.h).

s/accoring/according/

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
