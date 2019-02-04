Received: from eggs.gnu.org ([209.51.188.92]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqcjv-0007Tu-9F
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqcal-0007g2-KE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:39:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqcal-0007fE-8v
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:39:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so14008945wrs.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:39:09 -0800 (PST)
References: <1549268743-18502-1-git-send-email-thuth@redhat.com>
	<20190204101944.GE1905@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <483741c5-3b85-6690-282b-b715cf5ce3b8@redhat.com>
Date: Mon, 4 Feb 2019 12:39:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190204101944.GE1905@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/docker/test-mingw and docs: Remove
 --with-sdlabi=2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org

Hi Alex,

On 2/4/19 11:19 AM, Daniel P. Berrangé wrote:
> On Mon, Feb 04, 2019 at 09:25:43AM +0100, Thomas Huth wrote:
>> Patchew currently reports failures with the mingw docker test - this
>> is due to --with-sdlabi=2.0 configure flag which does not exist anymore.
>> Remove this remainder from the docker test and the docs now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  docs/multiseat.txt      | 2 +-
>>  tests/docker/test-mingw | 3 +--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

IMHO this patch can probably get directly applied as a build-fix, rather
than going thru qemu-trivial. Alex is that OK with you?

Regards,

Phil.
