Received: from eggs.gnu.org ([2001:4830:134:3::10]:42870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBku8-0002oX-AM
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBku7-0001yM-2d
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:42:00 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBku6-0001yG-Sh
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:41:58 -0400
Received: by mail-ot0-x233.google.com with SMTP id l13-v6so8265803otk.9
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:41:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23266.3638.876146.489411@mariner.uk.xensource.com>
References: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
	<CAFEAcA9cumr=t7mRZ-9KtLMWAK-9nVGmRsnXjJ+pc899ePxfVg@mail.gmail.com>
	<23266.3638.876146.489411@mariner.uk.xensource.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 18:41:37 +0100
Message-ID: <CAFEAcA_V_XodQRGAs=PosBZ5ZPBswnbqXbp-h7REijyqBVdkJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v9 00/16] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Alistair Francis <alistair.francis@wdc.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>

On 26 April 2018 at 18:36, Ian Jackson <ian.jackson@citrix.com> wrote:
> Peter Maydell writes ("Re: [PULL v9 00/16] xen: xen-domid-restrict improvements"):
>> Hi -- my apply-pullreq script thinks this isn't a signed tag:
>>
>> error: remotes/iwj/for-upstream.depriv-2: cannot verify a non-tag object of
>> type commit. Does not appear to be a signed tag
>
> It isn't.  It's not a tag at all.  It's a branch.
>
>> We only apply signed-tag pull requests these days; could you
>> create and sign a tag and resend the pullreq, please? (You
>> only need to resend the cover letter, not the whole set of
>> patches.)
>
> I can do that.  Alternatively you could manually verify the signature
> on my email and observe that it mentions the correct commit hash.

I could, but I hope you will appreciate that I'm not terribly
interested in trying to fathom the mysteries of gpg in order
to deal with a single pull request that doesn't appear in
the form that my tooling expects it to be and that every other
pull request I deal with comes in...

>> (https://wiki.qemu.org/Contribute/SubmitAPullRequest
>> is our process documentation on pull requests, but I think
>> everything else with this one is fine.)
>
> I read that.  It does not say that the pull request must refer to a
> signed tag.  It says that the pull request must be signed, so I signed
> my pull request by feeding the email body to gnupg.

I have fixed the wiki page to be clearer about what we mean by
"signed pull requests".

> Anyway, would you like me to make a signed tag and send you an
> unsigned email referring to it, then ?

Yes, please. (You can sign the email as well if you like, but I'm
not going to be checking that, so it will be wasted effort :-)).

thanks
-- PMM
