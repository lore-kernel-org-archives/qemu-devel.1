Received: from eggs.gnu.org ([2001:4830:134:3::10]:53820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cornN-0007kQ-RC
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cornM-0001ib-Tp
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:19:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cornM-0001iN-LA
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:19:52 -0400
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
	<CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <95e695ba-3ecc-5254-721e-b35ed08b8074@redhat.com>
Date: Fri, 17 Mar 2017 14:19:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On 17.03.2017 12:52, Peter Maydell wrote:
> On 17 March 2017 at 11:49, Daniel P. Berrange <berrange@redhat.com> wro=
te:
>> On Fri, Mar 17, 2017 at 11:08:22AM +0000, Peter Maydell wrote:
>>> We plan to drop support in a future QEMU release for host OSes
>>> and host architectures for which we have no test machine where
>>> we can build and run tests. For the 2.9 release, make configure
>>> print a warning if it is run on such a host, so that the user
>>> has some warning of the plans and can volunteer to help us
>>> maintain the port if they need it to continue to function.

I like your patch! ... but instead of completely aborting with
"Unsupported host OS" when an unexpected host operating system has been
detected, I'd maybe only print a warning and continue the configure
process - in case it is a POSIX-compatible system, there is at least a
small chance that QEMU can be compiled there.

>>> This commit flags up as deprecated the CPU architectures:
>>>  * ia64
>>>  * sparc
>>>  * anything which we don't have a TCG port for
>>>    (and which was presumably using TCI)
>>
>> This seems to imply that if we remove supported for these architecture=
s,
>> then TCI is no longer required either, or would there be other reasons
>> to want to keep TCI around, even when all host archs have a TCG port ?
>=20
> I've never really seen the point in TCI, but others do, which
> is why it's in the tree.

TCI is sometimes useful when debugging problems with TCG backends - you
then have something else to compare the behavior with. I think it might
also be useful when porting QEMU to new architectures.

So could you maybe change your patch that it does not warn when the user
has run configure with the "--enable-tcg-interpreter" option?

>>> This list is definitely too all-encompassing, and we should
>>> move at least some of the BSDs into "not-deprecated".

Right, I just had a look at the changelog, and people contributed at
least patches for FreeBSD and OpenBSD last year, so I'd move at least
those two to the "not-deprecated" list (and I guess at least the other
BSDs are also close enough to these two to be kept).

 Thomas
