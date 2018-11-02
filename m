Received: from eggs.gnu.org ([2001:4830:134:3::10]:38756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdks-0000WP-MF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIdkk-00028s-27
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:01:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIdkg-00026o-Ae
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:00:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id r10-v6so2847032wrv.6
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 11:00:57 -0700 (PDT)
References: <20181102115239.22485-1-peter.maydell@linaro.org>
	<20181102115239.22485-2-peter.maydell@linaro.org>
	<734a4792-df43-7715-822f-9670de47da19@redhat.com>
	<CAFEAcA8xKVn8Ga-DS8Waqysnwr1ncmxNW6rCjJSidKqTK82UAQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b3c9f8c-68fd-8264-37b5-c7d79f475d02@redhat.com>
Date: Fri, 2 Nov 2018 19:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8xKVn8Ga-DS8Waqysnwr1ncmxNW6rCjJSidKqTK82UAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 2/11/18 18:42, Peter Maydell wrote:
> On 2 November 2018 at 17:38, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> Hi Peter,
>>
>> On 2/11/18 12:52, Peter Maydell wrote:
>>> We can remove entirely the note in rebuild-expected-aml.sh
>>> about copying any new data files, because now they will
>>> be in the source directory, not the build directory, and
>>> no copying is required.
>>
>>
>> This doesn't seem true for out-of-tree builds.
> 
> In the old setup, running the rebuild-expected-aml.sh
> script is done in the build directory, and creates new
> data files in ./tests/acpi-test-data/, which must then be
> copied to the source directory.
> In the new setup, the script is still run in the build
> directory, but when new data files are created in
> ./tests/data/acpi/ they don't need to be copied anywhere,
> because the directory symlink means they're already in
> tests/data/acpi in the source directory structure.

Oh you are correct...
My other terminal output was not update and was displaying the inodes 
from a previous run. No problem then!

Thanks,

Phil.
