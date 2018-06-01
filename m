Received: from eggs.gnu.org ([2001:4830:134:3::10]:42599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOn8s-0006t8-GN
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOn8n-0008V9-Jm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:43:06 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:43753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOn8n-0008UV-5J
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:43:01 -0400
Received: by mail-pf0-x243.google.com with SMTP id j20-v6so12761107pff.10
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:43:01 -0700 (PDT)
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-2-richard.henderson@linaro.org>
	<CAFEAcA-EVGk=E=0z=DJyv0eCCvstV_jV3uoxAztvmhY4p76AzQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a70b602-2fd9-9276-5cb1-25d45358304d@linaro.org>
Date: Fri, 1 Jun 2018 09:42:57 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-EVGk=E=0z=DJyv0eCCvstV_jV3uoxAztvmhY4p76AzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] gdbstub: Return the fd from
 gdbserver_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, Evan Green <evgreen@chromium.org>

On 06/01/2018 01:59 AM, Peter Maydell wrote:
> On 31 May 2018 at 23:49, Richard Henderson <richard.henderson@linaro.org> wrote:
>> This will allow us to protect gdbserver_fd from the guest.
> 
> Ha, I hadn't realised we already had an internal-to-QEMU filedescriptor :-)

Two, in fact, if you count qemu_logfile.  ;-)


r~
