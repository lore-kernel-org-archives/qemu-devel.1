Received: from eggs.gnu.org ([2001:4830:134:3::10]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cq0I0-0007ph-46
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cq0Hv-0004Wy-ED
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cq0Hv-0004W5-7P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:36:07 -0400
References: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
	<87bmsv29ok.fsf@dusky.pond.sub.org>
	<CAFEAcA-XZ-STrvzv4nrxrMCd3ureKXpLeAFpoPktNYb++YMusQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1e5632c-2094-0352-05b3-7ddaee9c6ade@redhat.com>
Date: Mon, 20 Mar 2017 17:35:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XZ-STrvzv4nrxrMCd3ureKXpLeAFpoPktNYb++YMusQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hmp: gpa2hva and gpa2hpa hostaddr
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 20/03/2017 17:32, Peter Maydell wrote:
> On 20 March 2017 at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> I have some comments which feel kind of nit-picky, but since this
>>> is a public-facing HMP API I think they need attention since we only
>>> get one chance to get it right.
>>
>> HMP is not a stable interface.  If we get it wrong, we change it.  If
>> our change breaks your usage, you get to keep the pieces.
> 
> Oh yes, I had my HMP and QMP the wrong way round.
> 
> ...which reminds me that I thought we preferred all HMP commands
> to be implemented in terms of their QMP equivalent ?

Right, but we make exceptions for debug commands such as x or xp (and
these ones).

Paolo
