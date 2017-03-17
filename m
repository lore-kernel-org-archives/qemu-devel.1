Received: from eggs.gnu.org ([2001:4830:134:3::10]:50979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1coraK-0002Cy-GS
	for Qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1coraI-0005hu-JB
	for Qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:06:24 -0400
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:35664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1coraI-0005hd-CA
	for Qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:06:22 -0400
Received: by mail-ua0-x22e.google.com with SMTP id q7so43527164uaf.2
	for <Qemu-devel@nongnu.org>; Fri, 17 Mar 2017 06:06:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170315170205.GA3411@localhost.localdomain>
References: <CAF++6APFk2KY-7yFYtsgcTwn31RCf_Wxucp3eTLbB2e1c5QAyg@mail.gmail.com>
	<CAFEAcA9NPoujRE47pyNEui-DwxwisNpmGNp0w4B_+_mwbuV_4Q@mail.gmail.com>
	<CAF++6AN8-pKhPKNQPDnCkXzQdqo4hPTH6eJetuzQXmsBkDXRNA@mail.gmail.com>
	<CAF++6AMLAdzz0npAQYwenDOZJNqLgp+5oLNSR_R-XqFxhenKaw@mail.gmail.com>
	<CAFEAcA8gnWzkVupKJYG3kFZXi7Q-9d8J335b+sbbbL49YH3A_Q@mail.gmail.com>
	<20170315170205.GA3411@localhost.localdomain>
From: James Hanley <jhanley@dgtlrift.com>
Date: Fri, 17 Mar 2017 09:06:20 -0400
Message-ID: <CAF++6AO+C59nZ_-fUCkpEoYanD1CerakkpiZFsPjhnTyYJ03jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] submodule-update queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <Qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Thanks - that seemed to resolve the issue.  Will the synchronization
scripts be updated for all repositories? I was also seeing the same issue
when references for submodules roms/SLOF and roms/seabios were updated.
-Jim

On Wed, Mar 15, 2017 at 1:02 PM, Jeff Cody <jcody@redhat.com> wrote:

> On Wed, Mar 15, 2017 at 04:51:07PM +0000, Peter Maydell wrote:
> > On 15 March 2017 at 15:30, James Hanley <jhanley@dgtlrift.com> wrote:
> > > It would appear that the HTTP versions of the repo URLs are /not/
> > > referencing the same backend....
> > >
> > > jim@jim-VirtualBox:~$ git ls-remote http://git.qemu-project.org/
> git/dtc.git
> > > 3b9c97093d6e1067f4d24d2bff32f3dd24e0751e HEAD
> > > 827ac8eca016c39b13fc916bbdb16f9f2fe3c34c refs/heads/expressions
> > > 3b9c97093d6e1067f4d24d2bff32f3dd24e0751e refs/heads/master
> > > 17dab7023959256224e800dd77cae57d8ecfaec0 refs/heads/multi-v1-tags
> > > 5426757b714e4c142da488fe685220b732f69d7b refs/heads/testing
> > > 827ac8eca016c39b13fc916bbdb16f9f2fe3c34c refs/remotes/github/
> expressions
> > > 3b9c97093d6e1067f4d24d2bff32f3dd24e0751e refs/remotes/github/master
> > > 17dab7023959256224e800dd77cae57d8ecfaec0 refs/remotes/github/multi-v1-
> tags
> > > 5426757b714e4c142da488fe685220b732f69d7b refs/remotes/github/testing
> > > 827ac8eca016c39b13fc916bbdb16f9f2fe3c34c refs/remotes/origin/
> expressions
> > > 120775eb1cf39f8dcecd695c3ff1cfef8aeb669d refs/remotes/origin/master
> > > 17dab7023959256224e800dd77cae57d8ecfaec0 refs/remotes/origin/multi-v1-
> tags
> > > f5aa792d81f5911eff088e4f88c0cd0a11ea9ca0 refs/tags/dwg-last
> > > 0a1018321b08f89d0f1942c77802aa777a82d437 refs/tags/v1.0.0
> > > 5cb1fbdd7cf82e1909e27c81073cf3272cb63fa3 refs/tags/v1.0.0^{}
> > > 8e4751ca3600a2d82365e7e9d806f2bab9b81d56 refs/tags/v1.0.0-rc1
> > > 74ce242bf3307c7ec77b9ddfff443c247ac8c0a3 refs/tags/v1.0.0-rc1^{}
> > > 38738612dec55c0262de2192cbe655f499b8c5de refs/tags/v1.1.0
> > > 202863e4dd681d17c06a82943f49485bf7860633 refs/tags/v1.1.0^{}
> > > 2d38c152a6cbcd6fcd7a2f2535d3bc8860c975f9 refs/tags/v1.1.0-rc1
> > > 7364cc79b5fa11e416dce01802139bc87d690118 refs/tags/v1.1.0-rc1^{}
> > > 427b0062114703674688aa581d13499b1b2da896 refs/tags/v1.2.0
> > > 52c356d81b1b5b5426f53655e782c37793c3637e refs/tags/v1.2.0^{}
> > > 33ea8e2705c6905edcabda65dfa92af56716056b refs/tags/v1.2.0-rc1
> > > f8bf4bfc8796b46e6086a52f0cd6c1f9ed58645a refs/tags/v1.2.0-rc1^{}
> > > a532a5d2148e6a644bb56f7aa3d29297d19e30de refs/tags/v1.2.0-rc2
> > > 17773b0e5148c5ae281ee21492c871292cb7de20 refs/tags/v1.2.0-rc2^{}
> > > 00e38ce99a600e146aa20eac082b8d7d8ec70711 refs/tags/v1.3.0
> > > bc895d6d09695d05ceb8b52486ffe861d6cfbdde refs/tags/v1.3.0^{}
> > > 6d109a2e4885896d2665d4bbcc5bc985110b0950 refs/tags/v1.4.0
> > > 65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf refs/tags/v1.4.0^{}
> > > 29a9b5177c0bc192f7881b940932f903aca9c360 refs/tags/v1.4.1
> > > 302fca9f4c283e1994cf0a5a9ce1cf43ca15e6d2 refs/tags/v1.4.1^{}
> > > 24ec6e01bca89179d744d836fe94f2b459abd03d refs/tags/v1.4.2
> > > ec02b34c05be04f249ffaaca4b666f5246877dea refs/tags/v1.4.2^{}
> > > jim@jim-VirtualBox:~$
> > >
> > >
> > > Note that the tags for 1.4.3 and 1.4.4 are missing... Are the tags not
> > > "fetched" with the synchronization?
> >
> > Jeff, Stefan -- is something odd with the HTTP versions here?
> >
>
> Hi,
>
> Yes - the post-update hooks to populate the info/refs file (needed for
> http)
> is  not invokled when we update from our script.  I just did it manually
> for
> dtc.git, and I am now updating the script so that this will happen
> automatically.
>
> (The tags should now be present)
>
> Thanks,
> -Jeff
>
