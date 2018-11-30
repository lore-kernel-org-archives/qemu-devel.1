Received: from eggs.gnu.org ([2001:4830:134:3::10]:53791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSd6w-0003xO-Dg
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSd6r-0003gN-Ik
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:21:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSd6r-0003c0-Am
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:21:09 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <69af56c7-413d-857f-829b-37d4747d0d96@redhat.com>
Date: Fri, 30 Nov 2018 08:21:02 +0100
MIME-Version: 1.0
In-Reply-To: <1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 2018-11-29 21:43, Eric Blake wrote:
> On 11/29/18 11:45 AM, Paolo Bonzini wrote:
>> gtester is deprecated by upstream glib and it does not support tests
>> that call g_test_skip in some glib stable releases.
>>
>> glib suggests instead using Automake's TAP support.=C2=A0 We do not su=
pport
>> Automake, but we can copy the code that beautifies the TAP output and
>> use it.=C2=A0 I chose to use the Perl copy rather than the shell/awk o=
ne,
>> in order to reuse Perl's TAP parsing package, but I'm open to suggesti=
ons
>> about which language to use.
>=20
> I'm less familiar with the TAP protocol than I'd like to admit, but I
> did find:
>=20
> https://blog.gtk.org/2018/07/11/news-from-glib-2-58/
>=20
> which corroborates your claim that switching to Automake's TAP parser i=
s
> indeed a recommended approach to avoid the now-deprecated gtester.

Hmm, do we really have to maintain our own version of a test runner now?
There's already some effort going on to use avocado in "make
check-acceptance" ... maybe we could use avocado as replacement for
gtester, too?

 Thomas
