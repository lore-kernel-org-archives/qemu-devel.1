Received: from eggs.gnu.org ([2001:4830:134:3::10]:54447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gK42E-0007r0-NS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gK42A-0002jx-Ls
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:16:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gK428-0002Zh-Q0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:16:54 -0500
References: <20181105181353.39804-1-mst@redhat.com>
	<20181105181353.39804-3-mst@redhat.com>
	<a21e8e21-d056-1e9a-3726-54f8ce24a162@redhat.com>
	<20181106091147-mutt-send-email-mst@kernel.org>
	<4b68930c-1fc3-9462-8f9e-671b414e712d@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <2913be5b-f03e-b42c-1128-8f73ae7054f7@redhat.com>
Date: Tue, 6 Nov 2018 17:16:14 +0100
MIME-Version: 1.0
In-Reply-To: <4b68930c-1fc3-9462-8f9e-671b414e712d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/33] tests: Move
 tests/hex-loader-check-data/ to tests/data/hex-loader/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 06/11/2018 16:15, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/11/18 15:13, Michael S. Tsirkin wrote:
>> On Tue, Nov 06, 2018 at 02:27:18PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> On 5/11/18 19:14, Michael S. Tsirkin wrote:
>>>> From: Peter Maydell <peter.maydell@linaro.org>
>>>>
>>>> Currently tests/hex-loader-check-data contains data files used
>>>> by the hexloader-test, and configure individually symlinks those
>>>> data files into the build directory using a wildcard.
>>>>
>>>> Using a wildcard like this is a bad idea, because if a new
>>>> data file is added, nothing causes configure to be rerun,
>>>> and so no symlink is added for the new file. This can cause
>>>> tests to spuriously fail when they can't find their data.
>>>> Instead, it's better to symlink an entire directory of
>>>> data files. We already have such a directory: tests/data.
>>>>
>>>> Move the data files from tests/hex-loader-check-data/ to
>>>> tests/data/hex-loader/, and remove the unnecessary symlinking.
>>>>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>
>>> I reviewed/tested this patch too.
>>
>>
>> Thanks a lot Philippe!
>> It is unfortunately too late to update this patch info in git
>> commit history, however your help is still greatly appreciated!
>=20
> No worry, I'm not mad at all, but there might be an issue in your git P=
R
> workflow, this series also missed your maintainer S-o-b.
>=20
> Peter: Can you add a such check in your scripts? (during next merge
> window, no hurry).
>=20
> Rather than your scripts, this should be in scripts a maintainer can ru=
n
> locally, such ./scripts/checkpatch.pl --maintainer or
> ./scripts/checkseries.xx.

I think such tool already exists: with git-publish you can configure a
"pre-publish-send-email" hook, and check your S-o-B is present.

Thanks,
Laurent
