Received: from eggs.gnu.org ([2001:4830:134:3::10]:59427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIdTO-0004z2-5Y
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIdTN-0004z4-79
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:43:05 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIdTM-0004xj-Mf
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:43:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id z33so2271105otz.11
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 10:43:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <734a4792-df43-7715-822f-9670de47da19@redhat.com>
References: <20181102115239.22485-1-peter.maydell@linaro.org>
	<20181102115239.22485-2-peter.maydell@linaro.org>
	<734a4792-df43-7715-822f-9670de47da19@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 17:42:43 +0000
Message-ID: <CAFEAcA8xKVn8Ga-DS8Waqysnwr1ncmxNW6rCjJSidKqTK82UAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-3.1 1/4] tests: Move
 tests/acpi-test-data/ to tests/data/acpi/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 2 November 2018 at 17:38, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Hi Peter,
>
> On 2/11/18 12:52, Peter Maydell wrote:
>> We can remove entirely the note in rebuild-expected-aml.sh
>> about copying any new data files, because now they will
>> be in the source directory, not the build directory, and
>> no copying is required.
>
>
> This doesn't seem true for out-of-tree builds.

In the old setup, running the rebuild-expected-aml.sh
script is done in the build directory, and creates new
data files in ./tests/acpi-test-data/, which must then be
copied to the source directory.
In the new setup, the script is still run in the build
directory, but when new data files are created in
./tests/data/acpi/ they don't need to be copied anywhere,
because the directory symlink means they're already in
tests/data/acpi in the source directory structure.

thanks
-- PMM
