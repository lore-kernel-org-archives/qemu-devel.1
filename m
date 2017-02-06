Received: from eggs.gnu.org ([2001:4830:134:3::10]:54180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cai2k-0005zj-97
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cai2g-000855-4q
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:05:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cai2f-000842-TE
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:05:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v16C4ds5034018
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 07:05:08 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28db52dvct-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 07:05:08 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 6 Feb 2017 17:35:03 +0530
Date: Mon, 6 Feb 2017 17:34:56 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1485946146-21639-1-git-send-email-bharata@linux.vnet.ibm.com>
	<CAFEAcA_gno6etAWKkssBYSzYethD7_qNQh6CJCdviTNPqn2x9Q@mail.gmail.com>
	<20170203151246.GD12744@in.ibm.com>
	<CAFEAcA-Oqk4kKjpsyhqgAn9bZt7uNNiwt6bQm1mqj9P8j38dpg@mail.gmail.com>
	<20170206085819.GF12744@in.ibm.com>
	<CAFEAcA8yDPDAK2zips8vHZkZiCkp_ewJmv0691rRMA5cO6Hktw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8yDPDAK2zips8vHZkZiCkp_ewJmv0691rRMA5cO6Hktw@mail.gmail.com>
Message-Id: <20170206120456.GG12744@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add
 float128_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On Mon, Feb 06, 2017 at 10:31:49AM +0000, Peter Maydell wrote:
> On 6 February 2017 at 08:58, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> > On Fri, Feb 03, 2017 at 03:39:16PM +0000, Peter Maydell wrote:
> >> On 3 February 2017 at 15:12, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> >> > As I said above, it is based on float128_to_int64()
> >>
> >> Ah, right. I think that's probably a bad model to copy because
> >> it's a conversion to signed integer, not a conversion to
> >> unsigned integer (so the edge cases are different).
> >
> > I checked the original berkeley implementation and I see that
> > float128_to_uint64 implementation there also is based on
> > float128_to_int64 implementation with edge cases being different.
> >
> > To the best of my understanding, the corner cases for unsigned
> > int are covered in the above implemenation. Could you please
> > take a re-look at this ?
> 
> OK, but that's about 5 times harder to review because I have
> to work everything out from scratch rather than being able to
> say "yes, this is doing everything the same way that our
> existing known-to-be-good other function is doing it".

Fair enough. I will come up with a version of
float128_to_uint64_round_to_zero() based on the existing
float64_to_uint32_round_to_zero().

Regards,
Bharata.
