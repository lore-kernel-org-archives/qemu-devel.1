Received: from eggs.gnu.org ([2001:4830:134:3::10]:35681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1ewAJS-0005fE-1k
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1ewAJO-00065l-Tq
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:35:42 -0400
Date: Wed, 14 Mar 2018 13:35:33 -0400
In-Reply-To: <20180314172351.GA4764@localhost.localdomain>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180314172351.GA4764@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <7F85C9E4-D04F-474C-A8E3-2EAFC5B864B9@oracle.com>
Subject: Re: [Qemu-devel] CVE-2018-7550 (was: multiboot: bss_end_addr can be
 zero / cleanup)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ppandit@redhat.com, qemu-stable@nongnu.org

On March 14, 2018 1:23:51 PM EDT, Kevin Wolf <kwolf@redhat=2Ecom> wrote:
>Am 21=2E12=2E2017 um 18:25 hat Jack Schwartz geschrieben:
>> Properly account for the possibility of multiboot kernels with a zero
>> bss_end_addr=2E  The Multiboot Specification, section 3=2E1=2E3 allows =
for
>> kernels without a bss section, by allowing a zeroed bss_end_addr
>multiboot
>> header field=2E
>>=20
>> Do some cleanup to multiboot=2Ec as well:
>> - Remove some unused variables=2E
>> - Use more intuitive header names when displaying fields in messages=2E
>> - Change fprintf(stderr=2E=2E=2E) to error_report
>
>[ Cc: qemu-stable ]
>
>This series happens to fix CVE-2018-7550=2E
>http://www=2Eopenwall=2Ecom/lists/oss-security/2018/03/08/4
>
>Just a shame that we weren't told before merging it so that the
>appropriate tags could have been set in the commit message (and all of
>the problems could have been addressed; I'm going to send another
>Multiboot series now)=2E

Huh?

You mean the CVE tags that were created in 2018 for a patch posted in 2017=
?

Or that the reporter of the security issue didn't point to this particular=
 patch?

Irrespective of that,  is there a write-up  of how security process works =
at QEMU?

 That is what is the usual embargo period, the list of security folks, how=
 one can become one, what are the responsibilities, how changes to process =
are being carried out (and discussed), what breath of testing and PoC work =
is done , how security fixes are being reviewed, etc?

Thanks!

>
>Kevin
