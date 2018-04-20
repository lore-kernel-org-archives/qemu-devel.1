Received: from eggs.gnu.org ([2001:4830:134:3::10]:47530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9YE5-0002o7-Fr
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9YE2-0002F7-9K
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:45:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9YE1-0002EI-R7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:45:26 -0400
References: <87po2wzysh.fsf@dusky.pond.sub.org>
	<8a52bb49-4194-3b91-8b67-a0e5700fd6ed@redhat.com>
	<87in8nvdpn.fsf@dusky.pond.sub.org> <20180419075629.GC10259@redhat.com>
	<5ed8b01f-7faa-b23d-5fd2-f4715294e061@redhat.com>
	<20180419091201.GI10259@redhat.com>
	<a9006770-b4e3-cf57-3efa-c967740f7a94@redhat.com>
	<20180420093457.GE21035@redhat.com>
	<20180420094624.ltkg2jbugvgi4de5@sirius.home.kraxel.org>
	<20180420095053.GG21035@redhat.com>
	<20180420104154.gmqb26t4olj3mbcw@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <29b926f9-90df-8006-dfb3-d6133e3dba0c@redhat.com>
Date: Fri, 20 Apr 2018 17:45:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180420104154.gmqb26t4olj3mbcw@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 04/20/18 12:41, Gerd Hoffmann wrote:
>>>> Since your schema is likely to end up just being a file in docs/specs,
> 
>>> I think it would be useful to have this as part of the schema.  Should
>>> be easy then to write up a small utility then which takes a json file as
>>> input and translates that into qemu command line options.
>>
>> Currently we have two distinct QAPI schemas, one covering the system
>> emulator for QMP and subset of CLI args, and one covering the guest
>> agent.
> 
> Yep, we can make it a third one, fine with me.
> But it likewise wouldn't end up in docs/ then.

Let's please focus on the schema itself for now, with the stupid little
test command included. Once the schema enjoys universal popularity, I'll
be glad to pass it on to QMP wizards -- because, if we ultimately wanted
to keep the schema code-enabled, then Markus's earlier suggestions apply
too, regarding QMP test cases. I'll admit I haven't dared look at those
yet (in particular because Paolo originally suggested to move this under
docs/interop). Looking at my todo list, I'd really like to focus on the
schema itself.

Thanks
Laszlo
