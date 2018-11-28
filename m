Received: from eggs.gnu.org ([2001:4830:134:3::10]:48674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS26j-0004CY-CE
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS26e-0007Hn-Ea
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:50:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gS26e-0007H8-8S
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:50:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so21164524wrr.0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:50:28 -0800 (PST)
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
	<2ac07515-10f3-ed38-c022-e583cd1cd36a@redhat.com>
	<ed0252f7-e74c-46e1-b47b-8d0c2e8dd73e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d74ecc6-419e-0b93-c0a9-4a4ce37a7ca5@redhat.com>
Date: Wed, 28 Nov 2018 16:50:25 +0100
MIME-Version: 1.0
In-Reply-To: <ed0252f7-e74c-46e1-b47b-8d0c2e8dd73e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

On 28/11/18 15:39, Thomas Huth wrote:
> On 2018-11-28 15:34, Philippe Mathieu-Daudé wrote:
>> On 28/11/18 10:58, Thomas Huth wrote:
>>> Clang 3.4 does not know the "flatten" attribute yet. We've already
>>> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2,
>>> so use this macro now here, too, to fix this issue.
>>
>> checkpatch candidate?
> 
> I think we'd rather need a docker-based test with such an old version of
> Clang... (since there are also other issues like the double-typedef
> problem that regularly occurs there).

I was thinking of something such (broken code!):

  if ($line =~ /.*__attribute__\w+\(\(flatten\)\)/) {
    ERROR("Use QEMU_FLATTEN ...\n");
  }
