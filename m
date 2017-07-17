Received: from eggs.gnu.org ([2001:4830:134:3::10]:47640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX2Ku-00013l-DD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX2Kt-0003PE-Fp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:04 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX2Kt-0003Og-6n
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:03 -0400
Received: by mail-wm0-x229.google.com with SMTP id 70so20936011wmo.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 02:29:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717090531.GA7163@stefanha-x1.localdomain>
References: <20170717063521.GA7393@lemon>
	<20170717090531.GA7163@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 10:28:40 +0100
Message-ID: <CAFEAcA8kt71pbxggfLdP3-WCc8u8v5iijZBksMSq6Yss2ydgiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 10:05, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 17, 2017 at 02:35:21PM +0800, Fam Zheng wrote:
>> Q1: In the worst case, you get four individual auto replies from patchew. Is
>> that too many? Do you prefer one reply with all the results concatenated into
>> one?
>
> I'd like to avoid situations where one of the failure emails is sent
> hours after the others, because it's possible that the patch series
> author has already sent the next (still broken) revision by that time.
> The simplest way to avoid that is by sending just one email.
>
>> Q2: Some think the full log in the mail body is more than necessary. Is it
>> better or worse if it is a "tail -n 200" of the log in the body and the full log
>> attached?
>
> tail output and a link to the full logs would be nice.  Often there is a
> lot of irrelevant output.

Ideally we'd streamline our make process to not produce so much
irrelevant output :-)

-- PMM
