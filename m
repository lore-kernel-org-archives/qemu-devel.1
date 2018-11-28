Received: from eggs.gnu.org ([2001:4830:134:3::10]:54684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS1Ch-00047f-IT
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS108-0005yq-9D
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:39:40 -0500
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
	<2ac07515-10f3-ed38-c022-e583cd1cd36a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ed0252f7-e74c-46e1-b47b-8d0c2e8dd73e@redhat.com>
Date: Wed, 28 Nov 2018 15:39:28 +0100
MIME-Version: 1.0
In-Reply-To: <2ac07515-10f3-ed38-c022-e583cd1cd36a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1?] target/arm/sve_helper: Fix
 compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2018-11-28 15:34, Philippe Mathieu-Daud=C3=A9 wrote:
> On 28/11/18 10:58, Thomas Huth wrote:
>> Clang 3.4 does not know the "flatten" attribute yet. We've already
>> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2,
>> so use this macro now here, too, to fix this issue.
>=20
> checkpatch candidate?

I think we'd rather need a docker-based test with such an old version of
Clang... (since there are also other issues like the double-typedef
problem that regularly occurs there).

 Thomas
