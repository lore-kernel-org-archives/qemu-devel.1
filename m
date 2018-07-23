Received: from eggs.gnu.org ([2001:4830:134:3::10]:58303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhgmk-0001Tm-W4
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhgmh-0008R3-UC
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:46:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhgmh-0008Qu-NK
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:46:19 -0400
References: <20180723184752.22150-1-peter.maydell@linaro.org>
	<763fe1d3-e2ac-a3e6-69e7-edee07f3c578@redhat.com>
	<CAFEAcA-v_ntRi9rvAHP8_S+y45T5u02TVY4KdFVii6u6QJi=yg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a6ec0af-39a9-e1a7-05b8-e8cdad3aa367@redhat.com>
Date: Mon, 23 Jul 2018 14:46:17 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-v_ntRi9rvAHP8_S+y45T5u02TVY4KdFVii6u6QJi=yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>

On 07/23/2018 02:02 PM, Peter Maydell wrote:
> On 23 July 2018 at 19:59, Eric Blake <eblake@redhat.com> wrote:
>> In other words, why are we special-casing death-by-coredump, when ALL
>> non-zero exit status (whether or not a core dump was involved) is contrary
>> to the assumptions of the testsuite?
> 
> Because we're trying to get as much actual information
> as we have out into the logs, not merely "die so the test
> fails"...

Fair enough; so I posted a v2 based on your starting point:

https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg04438.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
