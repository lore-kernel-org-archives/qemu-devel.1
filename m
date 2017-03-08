Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clZfs-0004vD-QE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1clZfn-0003IY-UL
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:22:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1clZfn-0003IT-Oi
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:22:27 -0500
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
Date: Wed, 8 Mar 2017 12:22:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>

On 08.03.2017 11:03, Peter Maydell wrote:
> On 8 March 2017 at 09:26, Thomas Huth <thuth@redhat.com> wrote:
>> But anyway, the more important thing that keeps me concerned is: Someo=
ne
>>  once told me that we should get rid of old parameters and interfaces
>> (like HMP commands) primarily only when we're changing to a new major
>> version number. As you all know, QEMU has a lot of legacy options, whi=
ch
>> are likely rather confusing than helpful for the new users nowadays,
>> e.g. things like the "-net channel" option (which is fortunately even
>> hardly documented), but maybe also even the whole vlan/hub concept in
>> the net code, or legacy parameters like "-usbdevice". If we switch to
>> version 3.0, could we agree to remove at least some of them?
>=20
> I think if we are going to deprecate and remove options we need
> a clear transition plan for doing so, which means at least one
> release where options are "still works, but warn that they
> are going away with pointer to documentation or similar info
> about their replacement syntax", before actually dropping them.

Yes, that's certainly a good idea. But as Daniel suggested in his mail,
I think we should also have the rule that the option should be marked as
deprecated in multiple releases first - so that the users have a chance
to speak up before something gets really removed (otherwise the option
could be removed right on the first day after the initial release with
the deprecation message, so there is no time for the user to notice this
and complain). Not sure whether we need three releases, as Daniel
suggested, though, but if that's common sense, that's fine for me, too.

Anyway, I've now started a Wiki page where we could track the removal of
deprecated interfaces:

 http://wiki.qemu-project.org/Features/LegacyRemoval

Feedback / updates / addition of other legacy interfaces is welcome!

 Thomas
