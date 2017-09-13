Received: from eggs.gnu.org ([2001:4830:134:3::10]:59638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4Mb-0004hc-2r
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4MW-000284-6y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds4MW-00027H-0Z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:53:40 -0400
Date: Wed, 13 Sep 2017 11:53:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913115335.58995e36.cohuck@redhat.com>
In-Reply-To: <27c027c4-58b4-9031-648e-9fd2fa1e5fa8@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-2-pasic@linux.vnet.ibm.com>
	<20170906141846.0be413fb.cohuck@redhat.com>
	<bd30a18f-6d22-e5a7-6e8c-08f628466cc4@linux.vnet.ibm.com>
	<20170906145158.252cf0cd.cohuck@redhat.com>
	<27c027c4-58b4-9031-648e-9fd2fa1e5fa8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] s390x/css: introduce css data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 11 Sep 2017 18:36:00 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/06/2017 02:51 PM, Cornelia Huck wrote:
> >>>> +void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
> >>>> +{
> >>>> +    /*
> >>>> +     * We don't support MIDA (an optional facility) yet and we
> >>>> +     * catch this earlier. Just for expressing the precondition.
> >>>> +     */
> >>>> +    assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));    
> >>> I don't know, this is infrastructure, should it trust its callers? If
> >>> you keep the assert, please make it g_assert().    
> >>
> >> Why g_assert? I think g_assert comes form a test framework, this is not
> >> test code.  
> > g_assert() is glib, no?
> >   
> 
> It lives in GLib > GLib Utilities > Testing:
> https://developer.gnome.org/glib/stable/glib-Testing.html
> 
> The description of "Testing" starts like this: "GLib provides a framework
> for writing and maintaining unit tests in parallel to the code they are
> testing. The API is designed according to established concepts found in
> the other test frameworks (JUnit, NUnit, RUnit), which in turn is based
> on smalltalk unit testing concepts."
> 
> So yes, it's both glib and testing framework. This is why I
> ask why should one use g_assert in not-unit-test code.

I have searched the archives, but unfortunately was not able to come to
a conclusion. Checkpatch advises against using anything but g_assert or
g_assert_not_reached in anything but test code, but that is because
those other g_asserts can be made non-fatal. g_assert_not_reached does
not seem to have a non-glib equivalent.

I have it somewhere in the back of my mind that g_assert should be
preferred...
