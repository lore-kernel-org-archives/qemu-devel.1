Received: from eggs.gnu.org ([2001:4830:134:3::10]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cx6at-0005MR-4e
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 02:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cx6ao-0002EX-Fu
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 02:45:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:52319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cx6ao-0002EC-5r
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 02:44:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cx6am-0005ox-4V
	for <qemu-devel@nongnu.org>; Sun, 09 Apr 2017 06:44:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 208912E8060
	for <qemu-devel@nongnu.org>; Sun,  9 Apr 2017 06:44:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Apr 2017 06:35:31 -0000
From: Thomas Eschenbacher <Thomas.Eschenbacher@gmx.de>
Reply-To: Bug 1020309 <1020309@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120702214947.7655.69447.malonedeb@gac.canonical.com>
	<20170407133317.1846.44536.malone@chaenomeles.canonical.com>
Message-Id: <e6321dff-fc6d-f439-fb51-b8b3a47d19e2@gmx.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1020309] Re: qemu-system-ppc: no keyboard
 after savevm/loadvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thomas Huth wrote:

> Triaging old bug tickets ... can you still reproduce this issue with the
> latest version of QEMU (version 2.9)?
> =

> ** Changed in: qemu
>        Status: New =3D> Incomplete
> =


Hello Thomas,

here my answer per email:

I re-tested that simple sequence above and it seems to work now,
using qemu-2.8.0 !

I did not use qemu-ppc again in the past five years, so I can not tell
you "when" this got fixed (which exact version). At least it seems to
work "now" :-)



Unfortunately that stupid bugtracker seems to be broken, here what I get
when I press the button to send the "Post Comment" button:

Error

<!DOCTYPE html> <html xmlns=3D"http://www.w3.org/1999/xhtml" xml:lang=3D"en"
lang=3D"en" dir=3D"ltr"> <head> <meta charset=3D"UTF-8" /> <title>Error:
Launchpad system error</title> <link rel=3D"shortcut icon"
href=3D"/@@/launchpad.png" /> <link type=3D"text/css" rel=3D"stylesheet"
media=3D"screen, print" href=3D"/+icing/rev18343/combo.css" /> <script
type=3D"text/javascript"> var LP =3D { cache: {}, links: {} }; </script>
<script type=3D"text/javascript">var cookie_scope =3D '; Path=3D/; Secure;
Domain=3D.launchpad.net';</script> <script type=3D"text/javascript"
src=3D"/+combo/rev18343/?yui/yui/yui-min.js&amp;lp/meta.js&amp;yui/loader/l=
oader-min.js"></script>
<script type=3D"text/javascript"> var raw =3D null; if (LP.devmode) { raw =
=3D
'raw'; } YUI.GlobalConfig =3D { combine: true, comboBase:
'/+combo/rev18343/?', root: 'yui/', filter: raw, debug: false, fetchCSS:
false, maxURLLength: 2000, groups: { lp: { combine: true, base:
'/+combo/rev18343/?lp/', comboBase: '/+combo/rev18343/?', root: 'lp/',
// comes from including lp/meta.js modules: LP_MODULES, fetchCSS: false
} } }</script> <script type=3D"text/javascript"> // we need this to create
a single YUI instance all events and code // talks across. All instances
of YUI().use should be based off of // LPJS instead. LPJS =3D new YUI();
</script> <script id=3D"base-layout-load-scripts" type=3D"text/javascript">
//<![CDATA[ LPJS.use('base', 'node', 'console', 'event', 'oop', 'lp',
'lp.app.foldables','lp.app.sorttable', 'lp.app.inlinehelp',
'lp.app.links', 'lp.app.longpoll', 'lp.bugs.bugtask_index',
'lp.bugs.subscribers', 'lp.app.ellipsis',
'lp.code.branchmergeproposal.diff', 'lp.views.global', function(Y) {
Y.on("domready", function () { var global_view =3D new
Y.lp.views.Global(); global_view.render();
Y.lp.app.sorttable.SortTable.init(); Y.lp.app.inlinehelp.init_help();
Y.lp.activate_collapsibles(); Y.lp.app.foldables.activate();
Y.lp.app.links.check_valid_lp_links(); // Longpolling will only start if
// LP.cache.longpoll is populated. // We use Y.later to work around a
Safari/Chrome 'feature': // The mouse cursor stays 'busy' until all the
requests started during // page load are finished. Hence we want the
long poll request to start // right *after* the page has loaded.
Y.later(0, Y.lp.app.longpoll, Y.lp.app.longpoll.setupLongPollManager);
}); Y.on('lp:context:web_link:changed', function(e) { window.location =3D
e.new_value; }); }); //]]> </script> <script id=3D"base-helper-functions"
type=3D"text/javascript"> //<![CDATA[ // This code is pulled from lp.js
that needs to be available on every // request. Pulling here to get it
outside the scope of the YUI block. function setFocusByName(name) { //
Focus the first element matching the given name which can be focused.
var nodes =3D document.getElementsByName(name); var i, node; for (i =3D 0; i
< nodes.length; i++) { node =3D nodes[i]; if (node.focus) { try { //
Trying to focus a hidden element throws an error in IE8. if
(node.offsetHeight !=3D=3D 0) { node.focus(); } } catch (e) {
LPJS.use('console', function(Y) { Y.log('In setFocusByName(<' +
node.tagName + ' type=3D' + node.type + '>): ' + e); }); } break; } } }
function selectWidget(widget_name, event) { if (event && (event.keyCode
=3D=3D=3D 9 || event.keyCode =3D=3D=3D 13)) { // Avoid firing if user is ta=
bbing
through or simply pressing // enter to submit the form. return; }
document.getElementById(widget_name).checked =3D true; } //]]> </script>
</head> <body id=3D"document" itemscope=3D""
itemtype=3D"http://schema.org/WebPage" class=3D"tab-unknown main_only public
yui3-skin-sam"> <div class=3D"yui-d0"> <div id=3D"locationbar"
class=3D"login-logout"> <div id=3D"logincontrol"> <form action=3D"/+logout"
method=3D"post"> <input type=3D"hidden" name=3D"loggingout" value=3D"1" /> =
<a
href=3D"/~thomas-eschenbacher" class=3D"sprite person">Thomas Eschenbacher
(thomas-eschenbacher)</a> &bull; <input type=3D"submit" name=3D"logout"
value=3D"Log Out" /> </form> </div> </div><!--id=3D"locationbar"--> <div
id=3D"watermark" class=3D"watermark-apps-portlet"> <div> <img alt=3D""
width=3D"64" height=3D"64" src=3D"/@@/launchpad-logo" /> </div> <div
class=3D"wide"> <h2 id=3D"watermark-heading"><span>Launchpad.net</span></h2>
</div> <!-- Application Menu --> <ul class=3D"facetmenu"> </ul> </div>
<div id=3D"maincontent" class=3D"yui-main"> <div class=3D"yui-b" dir=3D"ltr=
">
<div class=3D"context-publication"> <div id=3D"registration"
class=3D"registering"> </div> </div> <div id=3D"request-notifications">
</div> <div class=3D"top-portlet"> <h1 class=3D"exception">No
<code>REFERER</code> Header</h1> <p>Launchpad requires a
<code>REFERER</code> header to perform this action. There is no
<code>REFERER</code> header present. This can be caused by configuring
your browser to block <code>REFERER</code> headers.</p> <p>Unblock
<code>REFERER</code> headers for launchpad.net and try again, or see <a
href=3D"https://answers.launchpad.net/launchpad/+faq/1024">the FAQ <em>Why
does Launchpad require a REFERER header?</em></a> for more
information.</p> <p>You can also join <a
href=3D"irc://chat.freenode.net/launchpad">the #launchpad IRC support
channel on chat.freenode.net</a> for further assistance.</p> </div>
</div><!-- yui-b --> </div><!-- yui-main --> <!-- yui-b side --> <!--
yui-t4 --> <div id=3D"footer" class=3D"footer"> <div class=3D"lp-arcana"> <=
div
class=3D"lp-branding"> <a href=3D"https://launchpad.net/"><img
src=3D"/@@/launchpad-logo-and-name-hierarchy.png" alt=3D"Launchpad" /></a>
&nbsp;&bull;&nbsp; <a href=3D"https://launchpad.net/+tour">Take the
tour</a> &nbsp;&bull;&nbsp; <a href=3D"https://help.launchpad.net/">Read
the guide</a> &nbsp; <form id=3D"globalsearch" method=3D"get"
accept-charset=3D"UTF-8" action=3D"https://launchpad.net/+search"> <input
type=3D"search" id=3D"search-text" name=3D"field.text" /> <input type=3D"im=
age"
src=3D"/@@/search" style=3D"vertical-align:5%" alt=3D"Search Launchpad" />
</form> </div> </div> <div class=3D"colophon"> &copy; 2004-2016 <a
href=3D"http://canonical.com/">Canonical&nbsp;Ltd.</a> &nbsp;&bull;&nbsp;
<a href=3D"https://launchpad.net/legal">Terms of use</a>
&nbsp;&bull;&nbsp; <a href=3D"/support">Contact Launchpad Support</a>
&nbsp;&bull;&nbsp; <a href=3D"http://blog.launchpad.net/">Blog</a>
&nbsp;&bull;&nbsp; <a
href=3D"http://www.canonical.com/about-canonical/careers">Careers</a>
&nbsp;&bull;&nbsp; <a href=3D"https://twitter.com/launchpadstatus">System
status</a> <span id=3D"lp-version"> &nbsp;&bull;&nbsp; r18343 (<a
href=3D"https://dev.launchpad.net/">Get the code!</a>) </span> </div>
</div> </div><!-- yui-d0--> <script>LP.links['me'] =3D
'/~thomas-eschenbacher';</script> <script
id=3D"json-cache-script">LP.cache =3D {"related_features": {}};</script>
</body> <!-- Facet name: unknown Page type: main_only Has global search:
True Has application tabs: True Has side portlets: False At least 4
queries/external actions issued in 0.05 seconds Features:
{'app.mainsite_only.canonical_url': None, 'js.yui_version': None,
'visible_render_time': None, 'baselayout.careers_link.disabled': None}
r18343 --> </html>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1020309

Title:
  qemu-system-ppc: no keyboard after savevm/loadvm

Status in QEMU:
  Incomplete

Bug description:
  Here the steps to reproduce:

  1. qemu-img create -f qcow2 test.qcow2 100M
  2. qemu-system-ppc -m 1024 -hda test.qcow2
  3. change to the console via Ctrl-Alt-2 and save a snapshot: "savevm test"
  4. quit
  5. start again and go to the console
  6. load the snapshot via "loadvm test"
  7. change back to the guest display (Ctrl-Alt-1)
  8. try to type something =3D> no keyboard
  9. the same via console, e.g. "sendkey 1" has no effect

  I tried the following branches from git:
  master, stable-1.0, stable-0.15 =

  =3D> all behave the same

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1020309/+subscriptions
