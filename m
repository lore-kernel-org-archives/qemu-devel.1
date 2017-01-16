Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTBvc-0006A6-DJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTBvb-0007w7-Ga
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:22:48 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:36413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTBvb-0007vn-C4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:22:47 -0500
Received: by mail-vk0-x233.google.com with SMTP id t8so78023807vke.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 10:22:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA880jLaLFBtmphjV6LEmzvMGNajTbgitzKDnpiPRHpB_g@mail.gmail.com>
References: <1483633930-7103-1-git-send-email-amit.shah@redhat.com>
	<CAFEAcA8nZmDsQvfX+=W3jDJU0rUThsn93fFNYgzxhEyWTx_kHQ@mail.gmail.com>
	<20170113033701.GA1955@amit-lp.rh>
	<CAFEAcA880jLaLFBtmphjV6LEmzvMGNajTbgitzKDnpiPRHpB_g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 18:22:26 +0000
Message-ID: <CAFEAcA-Rj2YJNWSLjV8y=bK=WpJ6eHPXH8k6nFuMD4pcCjDCxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] migration: QTAILQ migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit.shah@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu list <qemu-devel@nongnu.org>, Jianjun Duan <duanj@linux.vnet.ibm.com>

On 13 January 2017 at 09:43, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 13 January 2017 at 03:37, Amit Shah <amit.shah@redhat.com> wrote:
>> On (Fri) 06 Jan 2017 [12:10:22], Peter Maydell wrote:
>>> On 5 January 2017 at 16:32, Amit Shah <amit.shah@redhat.com> wrote:
>>> > The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:
>>> >
>>> >   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)
>>> >
>>> > are available in the git repository at:
>>> >
>>> >   https://git.kernel.org/pub/scm/virt/qemu/amit/migration.git tags/migration-for-2.9-1
>>> >
>>> > for you to fetch changes up to 8d0c57697abcc57166e918064d9a7f6c7316d01b:
>>> >
>>> >   migration: add error_report (2017-01-04 19:21:26 +0530)
>>> >
>>> > ----------------------------------------------------------------
>>> > Migration: migrate QTAILQ infrastructure for vmstate
>>> >
>>> > ----------------------------------------------------------------
>>>
>>> Hi. I'm afraid this fails 'make check' for ppc64be:
>>
>> Hi Peter, since this was due to something else, will you try to pull
>> this in again?  Or should I re-send the series?
>
> I've put it back on my list to process.

...but it fails to build on 32-bit:

/home/petmay01/qemu/tests/test-vmstate.c: In function 'test_load_q':
/home/petmay01/qemu/tests/test-vmstate.c:677:25: error: cast from
pointer to integer of different size [-Werror=pointer-to-int-cast]
     g_assert_cmpint((uint64_t) qele_from, ==, (uint64_t) qlast_from);
                         ^
/home/petmay01/qemu/tests/test-vmstate.c:677:56: error: cast from
pointer to integer of different size [-Werror=pointer-to-int-cast]
     g_assert_cmpint((uint64_t) qele_from, ==, (uint64_t) qlast_from);
                                                        ^
/home/petmay01/qemu/tests/test-vmstate.c:678:25: error: cast from
pointer to integer of different size [-Werror=pointer-to-int-cast]
     g_assert_cmpint((uint64_t) qele_to, ==, (uint64_t) qlast_to);
                         ^
/home/petmay01/qemu/tests/test-vmstate.c:678:54: error: cast from
pointer to integer of different size [-Werror=pointer-to-int-cast]
     g_assert_cmpint((uint64_t) qele_to, ==, (uint64_t) qlast_to);
                                                      ^
cc1: all warnings being treated as errors

Did you want uintptr_t ?

thanks
-- PMM
