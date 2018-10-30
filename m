Received: from eggs.gnu.org ([2001:4830:134:3::10]:51929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHVXv-0001s5-5y
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHVXq-0001fs-K9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:03:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHVXq-0001dn-Ct
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:03:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so12974467wrw.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 08:03:02 -0700 (PDT)
References: <20181030125005.28151-1-peter.maydell@linaro.org>
	<CAFEAcA_JvsqWPgauPmtp_jdgNOwi2zwcHexPSiLE-Eka+PcDTA@mail.gmail.com>
	<CAFEAcA91k6jx=XY5VbnA1JFWh+0Qv0T-zA9kcdid-jRtnh=s1A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc287aaf-61e2-3ed5-0f53-daf505b46047@redhat.com>
Date: Tue, 30 Oct 2018 16:02:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA91k6jx=XY5VbnA1JFWh+0Qv0T-zA9kcdid-jRtnh=s1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] configure: symlink directories,
 not wildcarded files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 30/10/18 14:08, Peter Maydell wrote:
> On 30 October 2018 at 13:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>> ...having sent this out and moved on to something else, I have
>> discovered a problem with it. If you configure a build tree
>> using this, and then switch back to a git branch which has
>> the older configure, then that configure will end up trashing
>> all the tests/acpi-test-data and tests/hex-loader-check-data
>> files in the source tree by replacing them with symlinks to
>> themselves... This is fixable by doing "git checkout tests"
>> but it's a bit of a landmine for bisection :-(

Got there now switching to another series after testing yours ;)

> Maybe we should standardize on having all data files for tests
> be in tests/data, which is and has always been a symlink to
> a directory. That would avoid this problem with old versions
> of configure mangling the source directory by accident.

This seems the clever move.

> 
> thanks
> -- PMM
> 
