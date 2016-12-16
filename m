Received: from eggs.gnu.org ([2001:4830:134:3::10]:58419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHrAw-0005tk-Is
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHrAv-0005yq-Fs
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:59:46 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHrAv-0005y8-2g
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 06:59:45 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 51so35914206uai.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 03:59:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAH47eN3roJHEezvR_ijdiS36kQaKLUCd-8h4uiGeFT1CUp3Qgg@mail.gmail.com>
References: <CAH47eN3AVo-4CWN8XHhVz5F811Dc-iS8pVmW+4EW_1mvbpVgpA@mail.gmail.com>
	<391977981.4066351.1481752314886.JavaMail.zimbra@redhat.com>
	<CAH47eN3roJHEezvR_ijdiS36kQaKLUCd-8h4uiGeFT1CUp3Qgg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 11:59:23 +0000
Message-ID: <CAFEAcA9UUGoq+EFQ5P4=vRu=+AdvhnDha6bNJbzY=mNNjMo-rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Making TCG configurable in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alvise Rigo <a.rigo@virtualopensystems.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, chao p peng <chao.p.peng@linux.intel.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, Claudio Fontana <Claudio.Fontana@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 December 2016 at 11:49, Alvise Rigo <a.rigo@virtualopensystems.com> wrote:
> On Wed, Dec 14, 2016 at 10:51 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The hardest part is making sure that it doesn't bitrot, and it's hard
>> because we don't have CI for architectures other than x86.  But at least
>> Peter builds on ARM, and target submaintainers do build on PPC and s390
>> so it's not that bad perhaps.
>
> Would a CI set up just to test this feature make sense?

If we had CI for multiple host architectures we'd just use it
routinely for everything. The difficulty is that there's nothing
public like Travis for non-x86 and historically we as a project
have not managed to maintain a local CI solution (we used to
have buildbots but their config just bitrotted).

We do include ARM and PPC in the standard set of build tests
before merging pull requests, though, so those are not completely
untested.

thanks
-- PMM
